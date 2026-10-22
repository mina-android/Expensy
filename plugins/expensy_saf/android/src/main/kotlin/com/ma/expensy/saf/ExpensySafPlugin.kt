package com.ma.expensy.saf

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import androidx.documentfile.provider.DocumentFile
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import java.io.OutputStream
import java.util.concurrent.Executors

class ExpensySafPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var activity: Activity? = null
    private var pendingResult: MethodChannel.Result? = null
    private val executor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())
    private lateinit var secretStore: SecretStore

    companion object {
        private const val CHANNEL_NAME = "com.ma.expensy/saf"
        private const val REQUEST_CODE_PICK_DIRECTORY = 42101
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        secretStore = SecretStore(context)
        channel = MethodChannel(binding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == REQUEST_CODE_PICK_DIRECTORY) {
            val result = pendingResult
            pendingResult = null
            if (result == null) return false

            if (resultCode == Activity.RESULT_OK && data?.data != null) {
                val uri = data.data!!
                val takeFlags = Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                try {
                    context.contentResolver.takePersistableUriPermission(uri, takeFlags)
                } catch (_: Exception) {}

                val docFile = DocumentFile.fromTreeUri(context, uri)
                val displayName = docFile?.name ?: uri.lastPathSegment ?: "Selected Folder"
                result.success(mapOf("uri" to uri.toString(), "name" to displayName))
            } else {
                result.success(null)
            }
            return true
        }
        return false
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "pickDirectory" -> {
                val act = activity
                if (act == null) {
                    result.error("NO_ACTIVITY", "pickDirectory requires an active foreground Activity", null)
                    return
                }
                if (pendingResult != null) {
                    result.error("ALREADY_ACTIVE", "A directory picker request is already active", null)
                    return
                }
                pendingResult = result
                val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
                    addFlags(
                        Intent.FLAG_GRANT_READ_URI_PERMISSION or
                        Intent.FLAG_GRANT_WRITE_URI_PERMISSION or
                        Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION
                    )
                }
                act.startActivityForResult(intent, REQUEST_CODE_PICK_DIRECTORY)
            }

            "checkAccess" -> {
                val uriStr = call.argument<String>("uri")
                if (uriStr.isNullOrEmpty()) {
                    result.success(mapOf("ok" to false, "reason" to "invalid_uri"))
                    return
                }
                val check = checkDirectoryAccess(uriStr)
                result.success(check)
            }

            "writeFile" -> {
                val treeUriStr = call.argument<String>("treeUri")
                val name = call.argument<String>("name")
                val mime = call.argument<String>("mime") ?: "application/octet-stream"
                val bytes = call.argument<ByteArray>("bytes")

                if (treeUriStr == null || name == null || bytes == null) {
                    result.error("INVALID_ARGS", "Missing required parameters for writeFile", null)
                    return
                }

                executor.execute {
                    try {
                        val access = checkDirectoryAccess(treeUriStr)
                        if (access["ok"] != true) {
                            postResult(result) {
                                result.error("ACCESS_DENIED", "Cannot access folder: ${access["reason"]}", null)
                            }
                            return@execute
                        }

                        val treeUri = Uri.parse(treeUriStr)
                        val folder = DocumentFile.fromTreeUri(context, treeUri)
                        if (folder == null || !folder.exists()) {
                            postResult(result) {
                                result.error("FOLDER_MISSING", "Target folder does not exist", null)
                            }
                            return@execute
                        }

                        // Write to .part file first
                        val partName = "$name.part"
                        val existingPart = folder.findFile(partName)
                        existingPart?.delete()

                        val partFile = folder.createFile("application/octet-stream", partName)
                            ?: throw IllegalStateException("Failed to create temporary part file")

                        context.contentResolver.openOutputStream(partFile.uri, "wt")?.use { os ->
                            os.write(bytes)
                            os.flush()
                        } ?: throw IllegalStateException("Failed to open output stream for part file")

                        val writtenSize = partFile.length()
                        if (writtenSize != bytes.size.toLong()) {
                            partFile.delete()
                            throw IllegalStateException("Size mismatch: expected ${bytes.size}, got $writtenSize")
                        }

                        // Delete existing destination file if present
                        val existingFinal = folder.findFile(name)
                        existingFinal?.delete()

                        var finalDoc = partFile
                        val renamed = partFile.renameTo(name)
                        if (!renamed) {
                            // Fallback if provider doesn't support rename: copy directly to final file
                            val directFinal = folder.createFile(mime, name)
                                ?: throw IllegalStateException("Failed to create final file during rename fallback")
                            context.contentResolver.openOutputStream(directFinal.uri, "wt")?.use { os ->
                                os.write(bytes)
                                os.flush()
                            } ?: throw IllegalStateException("Failed to write final file during fallback")
                            partFile.delete()
                            finalDoc = directFinal
                        }

                        postResult(result) {
                            result.success(mapOf(
                                "uri" to finalDoc.uri.toString(),
                                "size" to bytes.size
                            ))
                        }
                    } catch (e: Exception) {
                        postResult(result) {
                            result.error("WRITE_FAILED", e.localizedMessage ?: "Unknown write error", null)
                        }
                    }
                }
            }

            "listFiles" -> {
                val treeUriStr = call.argument<String>("treeUri")
                val prefix = call.argument<String>("prefix") ?: ""

                if (treeUriStr == null) {
                    result.error("INVALID_ARGS", "Missing treeUri", null)
                    return
                }

                executor.execute {
                    try {
                        val treeUri = Uri.parse(treeUriStr)
                        val folder = DocumentFile.fromTreeUri(context, treeUri)
                        if (folder == null || !folder.exists()) {
                            postResult(result) { result.success(emptyList<Map<String, Any>>()) }
                            return@execute
                        }

                        val files = folder.listFiles()
                            .filter { it.isFile && (prefix.isEmpty() || (it.name?.startsWith(prefix) == true)) }
                            .map { file ->
                                mapOf(
                                    "name" to (file.name ?: ""),
                                    "uri" to file.uri.toString(),
                                    "modified" to file.lastModified(),
                                    "size" to file.length()
                                )
                            }

                        postResult(result) { result.success(files) }
                    } catch (e: Exception) {
                        postResult(result) {
                            result.error("LIST_FAILED", e.localizedMessage ?: "Unknown list error", null)
                        }
                    }
                }
            }

            "deleteFile" -> {
                val fileUriStr = call.argument<String>("uri")
                if (fileUriStr == null) {
                    result.error("INVALID_ARGS", "Missing uri for deleteFile", null)
                    return
                }
                executor.execute {
                    try {
                        val fileUri = Uri.parse(fileUriStr)
                        val doc = DocumentFile.fromSingleUri(context, fileUri)
                        val deleted = doc?.delete() ?: false
                        postResult(result) { result.success(deleted) }
                    } catch (e: Exception) {
                        postResult(result) { result.success(false) }
                    }
                }
            }

            "releaseDirectory" -> {
                val uriStr = call.argument<String>("uri")
                if (uriStr != null) {
                    try {
                        val uri = Uri.parse(uriStr)
                        val flags = Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                        context.contentResolver.releasePersistableUriPermission(uri, flags)
                    } catch (_: Exception) {}
                }
                result.success(null)
            }

            "isSecretStoreAvailable" -> {
                result.success(secretStore.isAvailable())
            }

            "setSecret" -> {
                val key = call.argument<String>("key") ?: ""
                val value = call.argument<String>("value") ?: ""
                result.success(secretStore.setSecret(key, value))
            }

            "getSecret" -> {
                val key = call.argument<String>("key") ?: ""
                result.success(secretStore.getSecret(key))
            }

            "clearSecret" -> {
                val key = call.argument<String>("key") ?: ""
                secretStore.clearSecret(key)
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    private fun checkDirectoryAccess(uriStr: String): Map<String, Any> {
        val uri = Uri.parse(uriStr)
        val hasPersisted = context.contentResolver.persistedUriPermissions.any {
            it.uri == uri && it.isWritePermission
        }
        if (!hasPersisted) {
            return mapOf("ok" to false, "reason" to "permission_lost")
        }

        val folder = DocumentFile.fromTreeUri(context, uri)
        if (folder == null || !folder.exists()) {
            return mapOf("ok" to false, "reason" to "folder_missing")
        }
        if (!folder.canWrite()) {
            return mapOf("ok" to false, "reason" to "not_writable")
        }

        return mapOf("ok" to true, "reason" to "")
    }

    private fun postResult(result: MethodChannel.Result, block: () -> Unit) {
        mainHandler.post {
            try {
                block()
            } catch (_: Exception) {}
        }
    }
}
