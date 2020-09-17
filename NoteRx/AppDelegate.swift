//
//  AppDelegate.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splashViewModel = SplashViewModel()
        let splashViewController = SplashViewController.instantiate(withViewModel: splashViewModel)
        window?.rootViewController = splashViewController
        return true
    }
}
