//
//  PersonsViewConfiguration.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol PersonsViewConfiguration {
    func configure()
    func reloadData(persons: [Person], next: String?, needsRefreshing: Bool, isCalledOnScroll: Bool)
    func refresh(sender: UIRefreshControl)
}
