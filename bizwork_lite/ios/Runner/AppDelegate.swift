import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let CHANNEL = "com.example.bizwork_lite/platform_view"
    let METHOD_SWITCH_VIEW = "switchSettingView"
    var resultCHANNEL : FlutterResult?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, err) in
        print("granted: (\(granted)")
    }

    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: CHANNEL,
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({[weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread.
        if self?.METHOD_SWITCH_VIEW == call.method {
            self?.resultCHANNEL = result
            
            DispatchQueue.main.async {
                controller.present(SettingViewController(), animated: true, completion: nil)
            }
        } else {
            result(FlutterMethodNotImplemented);
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
