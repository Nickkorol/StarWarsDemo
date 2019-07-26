//
//  PersonsCoordinator.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol PersonsCoordinator {
    var main: UIViewController? { get }
    func run()
    func showDetail(person: Person)
}
