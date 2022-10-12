package com.example.flutter_content_provider

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterContentProviderPlugin */
class FlutterContentProviderPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var context: Context? = null


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_content_provider")
    channel.setMethodCallHandler(this)
  }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "insert" -> {
                try {
                    val values = ContentValues()
                    val arguments = call.arguments as Map<String, String>
                    arguments.keys.forEach {
                        values.put(it, arguments[it])
                    }

                    context!!.contentResolver.insert(FlutterContentProvider.CONTENT_URI, values)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(e.message ?: "", e.message ?: "", null)
                }
            }
            "query" -> {
                val key = call.arguments as String
                var cursor: Cursor? = null
                try {
                    cursor = context!!.contentResolver.query(
                        FlutterContentProvider.CONTENT_URI,
                        null,
                        key,
                        null,
                        null
                    )

                    if (cursor != null && cursor.moveToFirst()) {
                        val columnIndex = cursor.getColumnIndex(key)
                        result.success(cursor.getString(columnIndex))
                    } else {
                        result.success(null)
                    }
                } catch (e: Exception) {
                    result.error(e.message ?: "", e.message ?: "", null)
                } finally {
                    cursor?.close()
                }
            }
            "delete" -> {
                val key = call.arguments as String
                try {
                    context!!.contentResolver.delete(
                        FlutterContentProvider.CONTENT_URI, key, null
                    )
                    result.success(null)
                } catch (e: Exception) {
                    result.error(e.message ?: "", e.message ?: "", null)
                }
            }
        }
    }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
