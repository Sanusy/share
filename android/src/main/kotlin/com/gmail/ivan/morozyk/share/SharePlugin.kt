package com.gmail.ivan.morozyk.share

import android.content.ClipData
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** SharePlugin */
class SharePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "share")
        channel.setMethodCallHandler(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        context = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        context = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        context = binding.activity
    }

    override fun onDetachedFromActivity() {
        context = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "shareString" -> shareString(call.arguments as String)
            "shareImage" -> shareImage(call.arguments as String)
            else -> result.notImplemented()
        }
    }

    private fun shareString(stringToShare: String) {
        val sendIntent: Intent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, stringToShare)
            type = "text/plain"
        }

        val shareIntent = Intent.createChooser(sendIntent, null)
        context?.startActivity(shareIntent)
    }

    private fun shareImage(imagePath: String) {
        context?.let {
            val imageUri = FileProvider.getUriForFile(
                it,
                "${it.packageName}.fileprovider",
                copyToShareCacheFolder(File(imagePath))
            )
            val shareIntent: Intent = Intent().apply {
                action = Intent.ACTION_SEND
                putExtra(Intent.EXTRA_STREAM, imageUri)
                type = "image/jpeg"
            }

            shareIntent.setClipData(ClipData.newRawUri("", imageUri));
            shareIntent.addFlags(
                Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
            );
            it.startActivity(Intent.createChooser(shareIntent, null))
        }

    }

    private fun copyToShareCacheFolder(file: File): File {
        val folder = File(context!!.cacheDir, "share")
        if (!folder.exists()) {
            folder.mkdirs()
        }
        val newFile = File(folder, file.name)
        file.copyTo(newFile, true)
        return newFile
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
