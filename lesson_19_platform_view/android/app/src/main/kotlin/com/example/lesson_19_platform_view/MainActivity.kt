package com.example.lesson_19_platform_view

import android.content.BroadcastReceiver
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.content.Intent
import android.content.Context
import android.content.IntentFilter

class MainActivity : FlutterActivity() {

    private val androidViewIdButton = "INTEGRATION_ANDROID_BUTTON"
    private val androidViewIdEdit = "INTEGRATION_ANDROID_EDIT"

    private val eventsChannel = "EVENTS_4_SWAP"

    private val intentName = "SWAP_EVENT"
    private val intentMessageId = "SWAP_US!"

    private var receiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.platformViewsController.registry.registerViewFactory(androidViewIdButton, AndroidButtonViewFactory(flutterEngine.dartExecutor.binaryMessenger))
        flutterEngine.platformViewsController.registry.registerViewFactory(androidViewIdEdit, AndroidEditViewFactory(flutterEngine.dartExecutor.binaryMessenger))

        EventChannel(flutterEngine.dartExecutor, eventsChannel).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(args: Any?, events: EventChannel.EventSink) {
                        receiver = createReceiver(events)
                        applicationContext?.registerReceiver(receiver, IntentFilter(intentName))
                    }

                    override fun onCancel(args: Any?) {
                        receiver = null
                    }
                }
        )
    }

    fun createReceiver(events: EventChannel.EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                events.success(intent.getIntExtra(intentMessageId, 0))
            }
        }
    }


}



