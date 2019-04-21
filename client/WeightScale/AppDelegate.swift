import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool
    {
        
        window = UIWindow()

        let router = NavigationRouter()
        router.setup()

        window?.rootViewController = router.rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}

