//
//  SceneDelegate.swift
//  StoreList
//
//  Created by Andrei Bezlepkin on 3.08.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.window = self.window ?? UIWindow()
                self.window!.backgroundColor = UIColor(red: 0, green: 0.298, blue: 0.62, alpha: 1)
                self.window!.rootViewController = StoreListController()
                self.window!.makeKeyAndVisible()
                guard scene is UIWindowScene else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    func sceneWillResignActive(_ scene: UIScene) {
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

