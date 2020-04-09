//
//  DetailAssemblyImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class DetailAssemblyImpl: DetailAssembly {
    
    private let root: UIViewController!
    let containter: Container
    
    init(root: UIViewController, container: Container) {
        self.root = root
        self.containter = container
    }
    
    func assembly(person: Person) -> DetailCoordinator {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let identifier = String(describing: DetailViewController.self)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? DetailViewController else {
            fatalError("DetailViewController is needed")
        }
        let viewModel = DetailViewModelImpl()
        controller.viewModel = viewModel
        viewModel.manager = containter.resolve(URLSessionAPIManager.self)
        
        let coordinator = DetailCoordinatorImpl(root: root, mainViewController: controller)
        
        viewModel.coordinator = coordinator
        viewModel.view = controller
        viewModel.person = person
        
        return coordinator
    }
    
}
