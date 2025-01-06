package com.example.epicounter

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class CustomHomeView : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val widgetKey = "widget_data_$appWidgetId" // Chiave unica per ogni widget
            val imageName = widgetData.getString("$widgetKey:filename", null)
            val title = widgetData.getString("$widgetKey:title", "Anime")
            val description = widgetData.getString("$widgetKey:description", "")

            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                val imageName = widgetData.getString("filename", null)
                setImageViewBitmap(R.id.widget_image, BitmapFactory.decodeFile(imageName))
                setTextViewText(R.id.widget_title, widgetData.getString("title", ""))
                setTextViewText(R.id.widget_description, widgetData.getString("description", ""))

                // Intent per aprire l'app con i dettagli di questo anime
                val intent = Intent(context, MainActivity::class.java).apply {
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
                    putExtra("anime_title", title)
                }

                val pendingIntent = PendingIntent.getActivity(
                    context,
                    appWidgetId, // Intent univoco per ogni widget
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                setOnClickPendingIntent(R.id.widget_container, pendingIntent)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
