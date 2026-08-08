package com.ma.expensy

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray

class AccountsWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_accounts).apply {
                val intent = Intent(context, MainActivity::class.java).apply {
                    action = Intent.ACTION_VIEW
                    data = Uri.parse("expensy://accounts")
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val pendingIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val dataString = widgetData.getString("accounts_widget_data", null)
                
                if (dataString.isNullOrEmpty() || dataString == "[]") {
                    // Empty state
                    setViewVisibility(R.id.empty_state_text, View.VISIBLE)
                    setViewVisibility(R.id.accounts_content, View.GONE)
                } else {
                    setViewVisibility(R.id.empty_state_text, View.GONE)
                    setViewVisibility(R.id.accounts_content, View.VISIBLE)

                    // Hide all slots first
                    setViewVisibility(R.id.account_item_1, View.GONE)
                    setViewVisibility(R.id.account_item_2, View.GONE)
                    setViewVisibility(R.id.account_item_3, View.GONE)

                    try {
                        val array = JSONArray(dataString)
                        val limit = minOf(array.length(), 3)
                        
                        for (i in 0 until limit) {
                            val accountObj = array.getJSONObject(i)
                            val name = accountObj.getString("name")
                            val balance = accountObj.getString("balance")
                            
                            val (containerId, nameId, balanceId) = when (i) {
                                0 -> Triple(R.id.account_item_1, R.id.account_name_1, R.id.account_balance_1)
                                1 -> Triple(R.id.account_item_2, R.id.account_name_2, R.id.account_balance_2)
                                else -> Triple(R.id.account_item_3, R.id.account_name_3, R.id.account_balance_3)
                            }
                            
                            setViewVisibility(containerId, View.VISIBLE)
                            setTextViewText(nameId, name)
                            setTextViewText(balanceId, balance)
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }
                }
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
