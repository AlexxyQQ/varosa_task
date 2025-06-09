package com.example.device_info_channel

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.text.SimpleDateFormat
import java.util.*

/**
 * DeviceInfoChannelPlugin: A Flutter plugin for Android that provides device information
 * 
 * This plugin creates a bridge between Flutter (Dart) and native Android code,
 * allowing Flutter apps to access Android-specific device information like battery level,
 * charging status, device model, and system time.
 * 
 * Implements:
 * - FlutterPlugin: Core Flutter plugin interface for lifecycle management
 * - MethodCallHandler: Interface for handling method calls from Flutter
 */
class DeviceInfoChannelPlugin: FlutterPlugin, MethodCallHandler {
  // Late-initialized variables - will be set during plugin attachment
  private lateinit var channel : MethodChannel  // Communication channel with Flutter
  private lateinit var context: Context         // Android application context for system access

  /**
   * Called when the plugin is attached to the Flutter engine
   * 
   * @param flutterPluginBinding: Provides access to Flutter's binary messenger and context
   * 
   * This method:
   * 1. Creates a method channel for Flutter-Android communication
   * 2. Sets this class as the handler for method calls from Flutter
   * 3. Stores the Android context for later use in system calls
   */
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    // Create method channel with name "device_info_channel" - must match iOS and Flutter code
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_info_channel")
    
    // Set this class as the handler for incoming method calls from Flutter
    channel.setMethodCallHandler(this)
    
    // Store Android application context to access system services later
    context = flutterPluginBinding.applicationContext
  }

  /**
   * Method call handler - receives and processes method calls from Flutter
   * 
   * @param call: MethodCall - contains the method name and arguments from Flutter
   * @param result: Result - callback interface to send results back to Flutter
   * 
   * This method acts as a router, deciding what to do based on the method name
   * sent from Flutter. Uses if-else logic to handle different method calls.
   */
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getDeviceInfo") {
      // Handle the "getDeviceInfo" method call from Flutter
      try {
        // Try to get device information using Android APIs
        val deviceInfo = getDeviceInfo()
        // Send successful result back to Flutter
        result.success(deviceInfo)
      } catch (e: Exception) {
        // If an error occurs, send an error result back to Flutter with details
        result.error("DEVICE_INFO_ERROR", "Failed to get device info", e.message)
      }
    } else {
      // If the method name doesn't match any we handle, return "not implemented"
      // This tells Flutter that this plugin doesn't support the requested method
      result.notImplemented()
    }
  }

  /**
   * Private method to gather device information from Android system
   * 
   * @returns: Map<String, Any> - Map containing device information
   * 
   * This method accesses various Android system services to collect:
   * - Battery level and charging status using BatteryManager
   * - Device model information from Build class
   * - Current system time in UTC ISO format
   */
  private fun getDeviceInfo(): Map<String, Any> {
    // Get BatteryManager system service to access battery information
    // BatteryManager provides more reliable battery info than older methods
    val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    
    // Get current battery level as an integer percentage (0-100)
    // BATTERY_PROPERTY_CAPACITY returns the battery level directly as a percentage
    val batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    
    // Check if device is currently charging by examining battery status intent
    // Create an intent filter for battery changed broadcasts
    val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
    
    // Register a receiver to get current battery status (null receiver gets current state)
    val batteryStatus = context.registerReceiver(null, intentFilter)
    
    // Extract the charging status from the intent
    // EXTRA_STATUS contains current battery state (charging, discharging, full, etc.)
    val status = batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
    
    // Consider device as charging if status is either CHARGING or FULL
    // BATTERY_STATUS_FULL means charged but still connected to power
    val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING || 
                     status == BatteryManager.BATTERY_STATUS_FULL

    // Get device model information by combining manufacturer and model
    // Build.MANUFACTURER: Device manufacturer (e.g., "Samsung", "Google")
    // Build.MODEL: Device model (e.g., "SM-G975F", "Pixel 4")
    val deviceModel = "${Build.MANUFACTURER} ${Build.MODEL}"
    
    // Create current system time in ISO 8601 UTC format for consistency
    // SimpleDateFormat with UTC timezone ensures consistent timestamps across time zones
    val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", Locale.US)
    sdf.timeZone = TimeZone.getTimeZone("UTC")  // Force UTC to avoid timezone issues
    val systemTime = sdf.format(Date())  // Format current date/time

    // Return all collected information as a map
    // Keys must match what the Flutter/Dart code expects and should be consistent with iOS
    return mapOf(
      "batteryLevel" to batteryLevel,    // Int: Battery percentage (0-100)
      "deviceModel" to deviceModel,      // String: Manufacturer + Model (e.g., "Samsung SM-G975F")
      "isCharging" to isCharging,        // Boolean: Whether device is charging or full
      "systemTime" to systemTime         // String: UTC timestamp in ISO 8601 format
    )
  }

  /**
   * Called when the plugin is detached from the Flutter engine
   * 
   * @param binding: FlutterPluginBinding - the binding that's being detached
   * 
   * This method cleans up resources by removing the method call handler
   * to prevent memory leaks and ensure proper cleanup.
   */
  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    // Remove the method call handler to clean up and prevent memory leaks
    // Setting handler to null tells Flutter this plugin is no longer available
    channel.setMethodCallHandler(null)
  }
} 