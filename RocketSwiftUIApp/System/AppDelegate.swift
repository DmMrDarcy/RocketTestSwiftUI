//
//  AppDelegate.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private func sceneDelegate(_ application: UIApplication) -> SceneDelegate? {
        return application.windows
                .compactMap({ $0.windowScene?.delegate as? SceneDelegate })
                .first
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if ProcessInfo.processInfo.isiOSAppOnMac {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                exit(0)
            })
        }
        
        return true
    }

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }


    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}
