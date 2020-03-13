//
//  AppDelegate.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 22/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = AppCoordinatorImpl(root: window)
        coordinator?.run()
        coordinator?.showPersons()
        return true
    }

}

