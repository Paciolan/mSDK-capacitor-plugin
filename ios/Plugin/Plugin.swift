import Capacitor
import Foundation

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(PaciolanSdk)
public class PaciolanSdk: CAPPlugin {
    @objc func show(_ call: CAPPluginCall) {
        let config = call.getString("config") ?? ""

        let paciolanSDKViewController: UIViewController = PaciolanSDKViewController(string: config)
        DispatchQueue.main.async {
            self.bridge.viewController.present(paciolanSDKViewController, animated: true, completion: nil)
        }

        call.resolve([
            "config": config,
        ])
    }
}
