import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var router: Router?

    convenience override init() {
        self.init(router: NavigationRouter())
    }

    init(router: Router) {
        self.router = router
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool
    {
        
        window = UIWindow()

        router?.setup()

        window?.rootViewController = router?.rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}

