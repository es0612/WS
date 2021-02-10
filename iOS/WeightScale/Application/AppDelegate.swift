import UIKit
//import GoogleMobileAds
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var router: Router?

    convenience override init() {
        self.init(router: NavigationRouter(animated: true))
    }

    init(router: Router) {
        self.router = router
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool
    {

        FirebaseApp.configure()
        
        let adsInstance = GADMobileAds.sharedInstance()

        adsInstance.start(completionHandler: nil)

        window = UIWindow()

        router?.showMainTabBarScreen()

        window?.rootViewController = router?.rootViewController
        window?.makeKeyAndVisible()
        


        return true
    }

}

