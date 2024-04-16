//
//  SceneDelegate.swift
//  Tving-Clone-Project
//
//  Created by 서은수 on 4/16/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = LoginViewController()
        self.window?.makeKeyAndVisible()
    }
}