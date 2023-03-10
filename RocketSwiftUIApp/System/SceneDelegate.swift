//
//  SceneDelegate.swift
//  RocketSwiftUIApp
//
//  Created by Dmitriy Lukyanov on 14.02.2023.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        let environment = AppEnvironment.bootstrap()
        let contentView = AppMainView(vm: AppMainView.AppMainViewVM(container: environment.container))

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = ContentHostingController(rootView: AnyView(contentView))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
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

class ContentHostingController: UIHostingController<AnyView> {
      // 1. We change this variable
    private var currentStatusBarStyle: UIStatusBarStyle = .darkContent
      // 2. To change this property of `UIHostingController`
    override var preferredStatusBarStyle: UIStatusBarStyle {
        currentStatusBarStyle
    }
      // 3. A function we can call to change the style programmatically
    func changeStatusBarStyle(_ style: UIStatusBarStyle) {
        self.currentStatusBarStyle = style
          // 4. Required for view to update
        self.setNeedsStatusBarAppearanceUpdate()
    }
}
extension UIApplication {
      // 1. Function that we can call via `UIApplication.setStatusBarStyle(...)`
    class func setStatusBarStyle(_ style: UIStatusBarStyle) {
          // Get the root view controller, which we've set to be `ContentHostingController`
        if let vc = UIApplication.getKeyWindow()?.rootViewController as? ContentHostingController {
                 // Call the method we've defined
            vc.changeStatusBarStyle(style)
        }
    }
      // 2. Helper function to get the key window
    private class func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.windows.first{ $0.isKeyWindow }
    }
}
