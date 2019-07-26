//
//  DetailViewModelImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

final class DetailViewModelImpl: DetailViewModel {
    var person: Person!
    
    var coordinator: DetailCoordinator!
    weak var controller: DetailViewController?
    
    func viewDidLoad() {
        
    }
    
}
