//
//  PersonsCoordinatorImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class PersonsCoordinatorImpl {
    
    weak var root: UIViewController!
    weak var mainViewController: UIViewController!
    let container: Container
    
    init(root: UIViewController, mainViewController: UIViewController, container: Container) {
        self.root = root
        self.mainViewController = mainViewController
        self.container = container
    }
    
}

extension PersonsCoordinatorImpl: PersonsCoordinator {
    var main: UIViewController? { return mainViewController }
    
    func run() {
        root.present(mainViewController, animated: true)
    }
    
    func showDetail(person: Person) {
        let assembly = DetailAssemblyImpl(root: mainViewController, container: container)
        let coordinator = assembly.assembly(person: person)
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
