package com.example.flutter_content_provider

import android.content.ContentProvider
import android.content.ContentValues
import android.content.Context.MODE_PRIVATE
import android.content.SharedPreferences
import android.content.UriMatcher
import android.database.Cursor
import android.database.MatrixCursor
import android.net.Uri
import java.lang.IllegalArgumentException

class FlutterContentProvider : ContentProvider() {
    private val uriMatcher: UriMatcher = UriMatcher(UriMatcher.NO_MATCH)
    private lateinit var sharedPreferences: SharedPreferences
    private var acceptUriCode = 1

    init {
        uriMatcher.addURI(
            PROVIDER_NAME,
            DATA_KEY,
            acceptUriCode
        )
    }

    override fun onCreate(): Boolean {
        sharedPreferences = context!!.getSharedPreferences("FlutterContentProvider", MODE_PRIVATE)
        return true
    }

    override fun query(
        uri: Uri, projection: Array<String>?, selection: String?,
        selectionArgs: Array<String>?, sortOrder: String?
    ): Cursor? {
        when (uriMatcher.match(uri)) {
            acceptUriCode -> {
                val data = sharedPreferences.getString(selection, null)

                return if (data != null) {
                    val cursor = MatrixCursor(arrayOf(selection))
                    cursor.newRow().add(selection, data)
                    cursor.setNotificationUri(context!!.contentResolver, uri)
                    cursor
                } else {
                    null
                }
            }
            else -> throw IllegalArgumentException("Can not query shared prefs, invalid URI")
        }
    }

    override fun insert(uri: Uri, values: ContentValues?): Uri {
        when (uriMatcher.match(uri)) {
            acceptUriCode -> {
                val editor = sharedPreferences.edit()
                for (key in values!!.keySet()) {
                    editor.putString(key, values.get(key) as String)
                }
                editor.apply()
                context!!.contentResolver.notifyChange(uri, null)
                return uri
            }
            else -> throw IllegalArgumentException("Can not insert to shared prefs, invalid URI")
        }
    }

    override fun delete(
        uri: Uri,
        selection: String?,
        selectionArgs: Array<String>?
    ): Int {
        when (uriMatcher.match(uri)) {
            acceptUriCode -> {
                val editor = sharedPreferences.edit()
                editor.remove(selection)
                editor.apply()
                context!!.contentResolver.notifyChange(uri, null)
                return 1
            }
            else -> throw IllegalArgumentException("Can not delete shared prefs, invalid URI")
        }
    }

    override fun getType(uri: Uri): String? {
        throw NotImplementedError("getType is not implemented")
    }

    override fun update(
        uri: Uri,
        values: ContentValues?,
        selection: String?,
        selectionArgs: Array<out String>?
    ): Int {
        throw NotImplementedError("update is not implemented")
    }

    companion object {
        const val PROVIDER_NAME = "com.example.flutter_content_provider.provider"
        const val DATA_KEY = "dataKey"
        private const val URL = "content://${PROVIDER_NAME}/${DATA_KEY}"
        val CONTENT_URI: Uri = Uri.parse(URL)
    }
}