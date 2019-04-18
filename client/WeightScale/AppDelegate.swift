import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool
    {
        
        window = UIWindow()

        let rootViewController = InputViewController()
        rootViewController.view.backgroundColor = .white

        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}

