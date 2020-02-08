import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
<<<<<<< HEAD
    InitArgs(CommandLine.argc, CommandLine.unsafeArgv);  GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { return UIInterfaceOrientationMask(arrayLiteral: [UIInterfaceOrientationMask.landscapeLeft,UIInterfaceOrientationMask.landscapeRight]); }
=======
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
>>>>>>> 7bfdda0a3c8ea7faa13ccbb6c2a0b7e9a11ef939
}
