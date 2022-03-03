package com.example.lesson_19_ffi_bridge

import android.content.Context
import android.view.View
import android.widget.EditText
import io.flutter.plugin.platform.PlatformView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.BinaryMessenger

internal class AndroidEditView(context: Context, id: Int, creationParams: Map<String?, Any?>?, messenger: BinaryMessenger) : PlatformView, MethodCallHandler {
    private val edit: EditText = EditText(context)
    private val methodChannel: MethodChannel

    override fun getView(): View {
        return edit
    }

    override fun dispose() {}

    init {
        edit.setText("Android")
        methodChannel = MethodChannel(messenger, "CHANNEL_4_SWAP")
        methodChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "setText" -> setText(methodCall, result)
            "getText" -> getText(methodCall, result)
            else -> result.notImplemented()
        }
    }

    private fun setText(methodCall: MethodCall, result: Result) {
        val text = methodCall.arguments as String
        edit.setText(text)
        result.success(null)
    }

    private fun getText(methodCall: MethodCall, result: Result) {
        result.success(edit.getText())
    }
}