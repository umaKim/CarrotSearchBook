//
//  SceneDelegate.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window                = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene   = windowScene
        
        guard let window else { return }
        let appContainer      = AppContainerImplementation()
        appCoordinator        = AppCoordinator(window: window, container: appContainer)
        appCoordinator?.start()
    }
}
