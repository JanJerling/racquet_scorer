package com.racquet_scorer

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import androidx.annotation.NonNull
import android.view.MotionEvent
import com.samsung.wearable_rotary.WearableRotaryPlugin

class MainActivity: FlutterActivity() {
    override fun onGenericMotionEvent(event: MotionEvent?): Boolean {
        return when {
            WearableRotaryPlugin.onGenericMotionEvent(event) -> true
            else -> super.onGenericMotionEvent(event)
        }
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", "transparent")
        super.onCreate(savedInstanceState)
    }
}