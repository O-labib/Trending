//
//  AppDelegate.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppWindowManager.setupWindow()
        return true
    }
}
