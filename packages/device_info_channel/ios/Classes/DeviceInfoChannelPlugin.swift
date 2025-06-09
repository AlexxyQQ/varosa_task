// Import necessary frameworks for Flutter plugin and iOS device access
import Flutter
import UIKit

/**
 * DeviceInfoChannelPlugin: A Flutter plugin for iOS that provides device information
 * 
 * This plugin creates a bridge between Flutter (Dart) and native iOS code,
 * allowing Flutter apps to access iOS-specific device information like battery level,
 * charging status, device model, and system time.
 */
public class DeviceInfoChannelPlugin: NSObject, FlutterPlugin {
  
  /**
   * Plugin registration method - called automatically by Flutter when the plugin is loaded
   * 
   * @param registrar: FlutterPluginRegistrar - manages the plugin's lifecycle and communication
   * 
   * This method:
   * 1. Creates a method channel with name "device_info_channel" for Flutter-iOS communication
   * 2. Creates an instance of our plugin class
   * 3. Registers the instance as a delegate to handle method calls from Flutter
   */
  public static func register(with registrar: FlutterPluginRegistrar) {
    // Create a method channel - this is the communication bridge between Flutter and iOS
    // The channel name "device_info_channel" must match the name used in Flutter/Dart code
    let channel = FlutterMethodChannel(name: "device_info_channel", binaryMessenger: registrar.messenger())
    
    // Create an instance of our plugin to handle the actual method calls
    let instance = DeviceInfoChannelPlugin()
    
    // Register our instance as the handler for method calls coming from Flutter
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  /**
   * Method call handler - receives and processes method calls from Flutter
   * 
   * @param call: FlutterMethodCall - contains the method name and arguments from Flutter
   * @param result: @escaping FlutterResult - callback to send results back to Flutter
   * 
   * This method acts as a router, deciding what to do based on the method name
   * sent from Flutter. It uses a switch statement to handle different method calls.
   */
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getDeviceInfo":
      // Handle the "getDeviceInfo" method call from Flutter
      do {
        // Try to get device information
        let deviceInfo = try getDeviceInfo()
        // Send successful result back to Flutter
        result(deviceInfo)
      } catch {
        // If an error occurs, send a Flutter error back with details
        result(FlutterError(
          code: "DEVICE_INFO_ERROR", 
          message: "Failed to get device info", 
          details: error.localizedDescription
        ))
      }
    default:
      // If the method name doesn't match any we handle, return "not implemented"
      // This tells Flutter that this plugin doesn't support the requested method
      result(FlutterMethodNotImplemented)
    }
  }
  
  /**
   * Private method to gather device information from iOS system
   * 
   * @returns: [String: Any] - Dictionary containing device information
   * @throws: Can throw errors if system calls fail
   * 
   * This method accesses various iOS system APIs to collect:
   * - Battery level and charging status
   * - Device model information
   * - Current system time in ISO 8601 format
   */
  private func getDeviceInfo() throws -> [String: Any] {
    // Enable battery monitoring to access battery information
    // Note: This might slightly impact battery life, but it's necessary for accurate readings
    UIDevice.current.isBatteryMonitoringEnabled = true
    
    // Get battery level as a percentage (0-100)
    // UIDevice.current.batteryLevel returns a float between 0.0 and 1.0
    // We multiply by 100 and convert to Int to get a percentage
    let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
    
    // Check if device is currently charging
    // batteryState can be: .unknown, .unplugged, .charging, or .full
    // We consider both .charging and .full as "charging" states
    let isCharging = UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
    
    // Get device model (e.g., "iPhone", "iPad", "iPod touch")
    let deviceModel = UIDevice.current.model
    
    // Create current system time in ISO 8601 format with fractional seconds
    // This provides a standardized timestamp format that's consistent across platforms
    let formatter = ISO8601DateFormatter()
    // Configure formatter to include date, time, and fractional seconds
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    let systemTime = formatter.string(from: Date())
    
    // Return all collected information as a dictionary
    // Keys must match what the Flutter/Dart code expects
    return [
      "batteryLevel": batteryLevel,    // Int: Battery percentage (0-100)
      "deviceModel": deviceModel,      // String: Device type (iPhone, iPad, etc.)
      "isCharging": isCharging,        // Bool: Whether device is charging
      "systemTime": systemTime         // String: ISO 8601 formatted timestamp
    ]
  }
} 