//
//  PersonsCoordinatorImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

class PersonsCoordinatorImpl {
    
    weak var root: UIViewController!
    weak var mainViewController: UIViewController!
    
    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }
    
}

extension PersonsCoordinatorImpl: PersonsCoordinator {
    var main: UIViewController? { return mainViewController }
    
    func run() {
        root.present(mainViewController, animated: true)
    }
    
    func showDetail(person: Person) {
        let assembly = DetailAssemblyImpl(root: mainViewController)
        let coordinator = assembly.assembly(person: person)
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
