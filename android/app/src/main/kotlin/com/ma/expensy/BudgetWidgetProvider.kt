package com.ma.expensy

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray

class BudgetWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        for (appWidgetId in appWidgetIds) {
            val options = appWidgetManager.getAppWidgetOptions(appWidgetId)
            updateAppWidget(context, appWidgetManager, appWidgetId, widgetData, options)
        }
    }

    override fun onAppWidgetOptionsChanged(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int, newOptions: android.os.Bundle) {
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
        val widgetData = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        updateAppWidget(context, appWidgetManager, appWidgetId, widgetData, newOptions)
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int, widgetData: SharedPreferences, options: android.os.Bundle) {
        val views = RemoteViews(context.packageName, R.layout.widget_budget_small).apply {
            val intent = Intent(context, MainActivity::class.java).apply {
                action = Intent.ACTION_VIEW
                data = Uri.parse("expensy://budgets")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            val pendingIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            val dataString = widgetData.getString("budget_widget_data", null)
            if (dataString.isNullOrEmpty() || dataString == "[]") {
                // Empty state
                setViewVisibility(R.id.empty_state_text, View.VISIBLE)
                setViewVisibility(R.id.budget_content, View.GONE)
            } else {
                setViewVisibility(R.id.empty_state_text, View.GONE)
                setViewVisibility(R.id.budget_content, View.VISIBLE)

                // Hide all slots first
                setViewVisibility(R.id.budget_item_1, View.GONE)
                setViewVisibility(R.id.budget_item_2, View.GONE)
                setViewVisibility(R.id.budget_item_3, View.GONE)
                setViewVisibility(R.id.budget_item_4, View.GONE)
                setViewVisibility(R.id.budget_item_5, View.GONE)

                // MIN_HEIGHT is landscape height, MAX_HEIGHT is portrait height.
                // We use MIN_HEIGHT to ensure items fit regardless of orientation, or we can use the current orientation height.
                // An app widget's height in portrait is MAX_HEIGHT, in landscape is MIN_HEIGHT. We'll use the smaller of the two to prevent cutoff,
                // or just rely on ScrollView for overflow. Let's use MAX_HEIGHT for portrait, but with safer thresholds (item is ~64dp, root padding ~32dp).
                val widgetHeight = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT, 0)
                val maxSlots = when {
                    widgetHeight >= 380 -> 5
                    widgetHeight >= 300 -> 4
                    widgetHeight >= 230 -> 3
                    widgetHeight >= 160 -> 2
                    else -> 1
                }

                try {
                    val array = JSONArray(dataString)
                    val limit = minOf(array.length(), maxSlots)
                    
                    for (i in 0 until limit) {
                        val budgetObj = array.getJSONObject(i)
                        val category = budgetObj.getString("category")
                        val spent = budgetObj.getDouble("spent")
                        val amount = budgetObj.getDouble("amount")
                        val progress = budgetObj.getDouble("progress")
                        val exceeded = budgetObj.getBoolean("exceeded")
                        val currency = budgetObj.getString("currency")
                        
                        val (containerId, nameId, amountId, progressId) = when (i) {
                            0 -> listOf(R.id.budget_item_1, R.id.budget_name_1, R.id.budget_amount_1, R.id.budget_progress_bar_1)
                            1 -> listOf(R.id.budget_item_2, R.id.budget_name_2, R.id.budget_amount_2, R.id.budget_progress_bar_2)
                            2 -> listOf(R.id.budget_item_3, R.id.budget_name_3, R.id.budget_amount_3, R.id.budget_progress_bar_3)
                            3 -> listOf(R.id.budget_item_4, R.id.budget_name_4, R.id.budget_amount_4, R.id.budget_progress_bar_4)
                            else -> listOf(R.id.budget_item_5, R.id.budget_name_5, R.id.budget_amount_5, R.id.budget_progress_bar_5)
                        }
                        
                        setViewVisibility(containerId, View.VISIBLE)
                        setTextViewText(nameId, category)
                        setTextViewText(amountId, "${String.format("%.0f", spent)} / ${String.format("%.0f", amount)} $currency")
                        
                        val progressInt = (progress * 100).toInt().coerceIn(0, 100)
                        setProgressBar(progressId, 100, progressInt, false)
                        
                        val colorRes = when {
                            exceeded -> R.color.budget_red
                            progress >= 0.8 -> R.color.budget_orange
                            else -> R.color.budget_primary
                        }
                        setTextColor(amountId, context.getColor(colorRes))
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}
