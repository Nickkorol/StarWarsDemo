//
//  DetailAssembly.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

protocol DetailAssembly {
    func assembly(person: Person) -> DetailCoordinator
}
