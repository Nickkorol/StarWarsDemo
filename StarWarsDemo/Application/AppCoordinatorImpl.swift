//
//  AppCoordinatorImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

final class AppCoordinatorImpl {
    private weak var root: UIWindow?
    private let mainViewController: MainContainer!
    let container: Container
    
    init(root: UIWindow?) {
        self.root = root
        container = Container() { container in
            container.register(URLSessionAPIManager.self) { _ in
                URLSessionAPIManagerImpl.shared
            }
        }
        let identifier = String(describing: MainContainer.self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? MainContainer else {
            fatalError("MainContainer is needed")
        }
        mainViewController = controller
    }
}

extension AppCoordinatorImpl: AppCoordinator {
    func run() {
        root?.rootViewController = mainViewController
        root?.makeKeyAndVisible()
    }
    
    func showPersons() {
        let assembly = PersonAssemblyImpl(root: mainViewController, container: container)
        let coordinator = assembly.assembly()
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.show(viewController, sender: nil)
    }
    
}
