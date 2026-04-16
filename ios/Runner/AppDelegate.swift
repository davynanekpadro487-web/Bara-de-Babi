import Flutter
import UIKit

@main
<<<<<<< HEAD
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
=======
@objc class AppDelegate: FlutterAppDelegate {
>>>>>>> 75fc9922d75a8d1b774714443b10c26292692c2e
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
<<<<<<< HEAD
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
=======
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
>>>>>>> 75fc9922d75a8d1b774714443b10c26292692c2e
}
