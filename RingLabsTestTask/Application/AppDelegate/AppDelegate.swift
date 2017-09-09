//
//  AppDelegate.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let appAssembly = AppAssembly()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = appAssembly.router.rootViewController()
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}
