import Flutter
import UIKit

public class SharePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "share", binaryMessenger: registrar.messenger())
        let instance = SharePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "shareString":
            if let stringToShare = call.arguments as? String {
                shareString(stringToShare: stringToShare)
            }
        case "shareImage":
            if let imagePath = call.arguments as? String {
                shareImage(imagePath: imagePath)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func shareString(stringToShare: String) {
        UIApplication.presentActivityViewController(activityItems: [stringToShare])
    }

    private func shareImage(imagePath: String) {
        UIApplication.presentActivityViewController(activityItems: [URL(fileURLWithPath: imagePath)])
    }

}

extension UIApplication {
    class func presentActivityViewController(activityItems: [Any]) {
        if(!activityItems.isEmpty) {
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            shared.keyWindow?.rootViewController?.present(activityViewController, animated: true)
        }
    }
}
