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
//            PlatformViewController* platformViewController =
//                [controller.storyboard instantiateViewControllerWithIdentifier:@"PlatformView"];
//            platformViewController.counter = ((NSNumber*)call.arguments).intValue;
//            platformViewController.delegate = self;
//            UINavigationController* navigationController =
//                [[UINavigationController alloc] initWithRootViewController:platformViewController];
//            navigationController.navigationBar.topItem.title = @"Platform View";
//            [controller presentViewController:navigationController animated:NO completion:nil];
        } else {
            result(FlutterMethodNotImplemented);
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
