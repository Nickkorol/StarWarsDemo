//
//  DetailCoordinatorImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

class DetailCoordinatorImpl {
    
    weak var root: UIViewController!
    weak var mainViewController: UIViewController!
    
    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }
    
}

extension DetailCoordinatorImpl: DetailCoordinator {
    var main: UIViewController? { return mainViewController }
    
    func run() {
        root.present(mainViewController, animated: true)
    }
}
