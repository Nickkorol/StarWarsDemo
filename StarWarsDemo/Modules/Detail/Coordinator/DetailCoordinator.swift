//
//  DetailCoordinator.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol DetailCoordinator {
    var main: UIViewController? { get }
    func run()
}
