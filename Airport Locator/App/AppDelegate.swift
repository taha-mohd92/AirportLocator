//
//  AppDelegate.swift
//  Airport Locator
//
//  Created by Mohd Taha on 19/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        Routing.launch(window: window!)
        return true
    }
}

