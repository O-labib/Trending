//
//  AppWindowManager.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

enum AppWindowManager {
    static func setupWindow() {
        window = .init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()

        window.rootViewController = entryViewController
    }
}

private extension AppWindowManager {
    static var window: UIWindow {
        get {
            (UIApplication.shared.delegate as? AppDelegate)!.window!
        }
        set {
            (UIApplication.shared.delegate as? AppDelegate)?.window = newValue
        }
    }

    static var entryViewController: UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }
}
