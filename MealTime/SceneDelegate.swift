//
//  SceneDelegate.swift
//  MealTime
//
//  Created by Роман Елфимов on 15.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        let tabBar = window?.rootViewController as! UITabBarController
        let nvc = tabBar.viewControllers?.first as! UINavigationController
        let waterVC = nvc.viewControllers.first as! WaterViewController
        waterVC.abc()
        print("sceneDidBecomeActive")
        
        
        
        if waterVC.launchedBefore  {
            print("Not first launch.")
            waterVC.waterGlass = waterVC.getWaterGlass()
            waterVC.allWater = waterVC.getAllWater()
            waterVC.textForLabelAndProgress()
        } else {
            print("First launch, setting UserDefault.")
            waterVC.saveAllWater(allWater: 1500)
            waterVC.saveWaterGlass(waterGlass: 150)
            //waterProg = 0
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
    }
    
    
    func sceneWillResignActive(_ scene: UIScene) {
        
        let tabBar = window?.rootViewController as! UITabBarController
        let nvc = tabBar.viewControllers?.first as! UINavigationController
        let waterVC = nvc.viewControllers.first as! WaterViewController
        waterVC.saveWaterProgress(progress: waterVC.waterProg)
        
        print("sceneWillResignActive")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

