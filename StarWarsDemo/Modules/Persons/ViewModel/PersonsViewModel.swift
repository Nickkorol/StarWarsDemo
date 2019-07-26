//
//  PersonsViewModel.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

protocol PersonsViewModel {
    func viewDidLoad()
    func requestPersons(needsRefreshing: Bool, isCalledOnScroll: Bool)
    func detailDidPress(person: Person)
    
    var numberOfPage: Int { get set }
    var hasFinishedDownloading: Bool { get }
}
