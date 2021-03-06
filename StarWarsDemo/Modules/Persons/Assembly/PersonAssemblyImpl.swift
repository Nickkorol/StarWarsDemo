//
//  PersonAssemblyImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class PersonAssemblyImpl: PersonAssembly {
    
    private let root: UIViewController!
    
    init(root: UIViewController) {
        self.root = root
    }
    
    func assembly() -> PersonsCoordinator {
        let storyboard = UIStoryboard(name: "Persons", bundle: nil)
        let identifier = String(describing: PersonsViewController.self)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? PersonsViewController else {
            fatalError("PersonsViewController is needed")
        }
        let viewModel = PersonsViewModelImpl()
        controller.viewModel = viewModel
        
        let coordinator = PersonsCoordinatorImpl(root: root, mainViewController: controller)
        
        viewModel.coordinator = coordinator
        viewModel.view = controller
        
        return coordinator
    }
    
}
