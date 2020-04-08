//
//  PersonAssemblyImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

final class PersonAssemblyImpl: PersonAssembly {
    
    private let root: UIViewController!
    var container = Container()
    
    init(root: UIViewController, container: Container) {
        self.root = root
        self.container = container
        self.container.register(PersonsViewModel.self) { r in
            let viewModel = PersonsViewModelImpl()
            //viewModel.coordinator = r.resolve(PersonsCoordinator.self)
            //Если определить coordinator для viewModel, то во ViewController viewModel будет nil
            viewModel.view = r.resolve(PersonsViewInput.self)
            viewModel.manager = r.resolve(URLSessionAPIManager.self)
            return viewModel
        }
        
        self.container.register(PersonsViewInput.self) { r in
            //Как определить ViewInput?
            let storyboard = SwinjectStoryboard.create(name: "Persons", bundle: nil, container: container)
            
            let identifier = String(describing: PersonsViewController.self)
            guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? PersonsViewController else {
                fatalError("PersonsViewController is needed")
            }
            return controller
        }
        
        self.container.storyboardInitCompleted(PersonsViewController.self) { (resolver, viewController) in
            viewController.viewModel = resolver.resolve(PersonsViewModel.self)
        }
        
        self.container.register(PersonsCoordinator.self) { r in
            let storyboard = SwinjectStoryboard.create(name: "Persons", bundle: nil, container: container)
            
            let identifier = String(describing: PersonsViewController.self)
            
            guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? PersonsViewController else {
                fatalError("PersonsViewController is needed")
            }
            let coordinator = PersonsCoordinatorImpl(root: root, mainViewController: controller)
            
            return coordinator
        }
    }
    
    func assembly() -> PersonsCoordinator {
        
        guard let coordinator = container.resolve(PersonsCoordinator.self) else { fatalError("PersonsCoordinator is needed") }
        
        return coordinator
    }
    
}
