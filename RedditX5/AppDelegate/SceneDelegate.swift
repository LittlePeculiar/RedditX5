//
//  SceneDelegate.swift
//  RedditX5
//
//  Created by Gina Mullins on 10/30/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var homeVC: HomeVC!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            homeVC = HomeVC(with: HomeVM(with: API()))
            homeVC.view.backgroundColor = .blue
            
            window?.rootViewController = UINavigationController(rootViewController: homeVC)
            window?.makeKeyAndVisible()
        }
        
    }

}

