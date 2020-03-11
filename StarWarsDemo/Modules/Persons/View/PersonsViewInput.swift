//
//  PersonsViewInput.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 11.03.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol PersonsViewInput: class {
    func configure()
    func reloadData(persons: [Person], next: String?, needsRefreshing: Bool, isCalledOnScroll: Bool)
}
