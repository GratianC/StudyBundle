//
//  AppDelegate.swift
//  StudyBundle
//
//  Created by GratianC on 2022/4/4.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        //在iOS13时，你会发现UI界面并没有任何反应，之所以无效，是因为你使用了iOS 13 的SceneDelegate
//        let windowScene = UIApplication.shared.connectedScenes.filter {
//            $0.activationState == .foregroundActive
//        }.first
//        if let windowScene = windowScene as? UIWindowScene {
//            //该window是全局变量
//            window = UIWindow(windowScene: windowScene)
//            window?.frame = UIScreen.main.bounds
//            window?.backgroundColor = .white
//            window?.windowLevel = UIWindow.Level.statusBar + 1
//            window!.makeKeyAndVisible()
//            let vc = ViewController()
//            let navigation = UINavigationController(rootViewController: vc)
//            window!.rootViewController = navigation
        //        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.windowLevel = UIWindow.Level.statusBar + 1
        window?.makeKeyAndVisible()
        let vc = ViewController()
        let navigation = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigation
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

