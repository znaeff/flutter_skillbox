package com.example.lesson_19_platform_view

import android.content.Context
import android.content.Intent
import android.view.View
import android.widget.Button
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

internal class AndroidButtonView(context: Context, id: Int, creationParams: Map<String?, Any?>?, messenger: BinaryMessenger) : PlatformView {
    private val button: Button = Button(context)

    private val intentName = "SWAP_EVENT"
    private val intentMessageId = "SWAP_US!"

    override fun getView(): View {
        return button
    }

    override fun dispose() {}

    init {
        button.textSize = 12f
        button.text = "Swap us here ..."
        button.setOnClickListener {
            val intent = Intent(intentName)
            intent.putExtra(intentMessageId, 1)
            context.sendBroadcast(intent)
        }

    }

}