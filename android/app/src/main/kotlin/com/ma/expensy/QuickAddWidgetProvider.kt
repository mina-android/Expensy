package com.ma.expensy

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

/**
 * OS-level "Quick Add Transaction" home screen widget (App Widget, not a
 * Flutter widget — see HOMESCREEN_WIDGET.md §0). Static tap target only,
 * no data display, so no home_widget plugin dependency is needed here —
 * this file stays dependency-free per HOMESCREEN_WIDGET.md §3.3.
 */
class QuickAddWidgetProvider : AppWidgetProvider() {

    companion object {
        // Single source of truth for the extra name/value so MainActivity
        // and this provider can never drift out of sync.
        const val EXTRA_ROUTE = "route"
        const val ROUTE_QUICK_ADD = "quick_add_transaction"
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.quick_add_widget)

            val launchIntent = Intent(context, MainActivity::class.java).apply {
                action = Intent.ACTION_VIEW
                putExtra(EXTRA_ROUTE, ROUTE_QUICK_ADD)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP
            }

            val pendingIntent = PendingIntent.getActivity(
                context,
                widgetId, // unique per widget instance, mirrors the notification
                          // ID stability convention (CLAUDE.md §15 rule 14)
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            views.setOnClickPendingIntent(R.id.quick_add_icon, pendingIntent)
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
