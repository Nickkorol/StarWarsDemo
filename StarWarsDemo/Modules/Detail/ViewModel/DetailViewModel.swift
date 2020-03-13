//
//  DetailViewModel.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 26/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

protocol DetailViewModel {
    func viewDidLoad()
    
    var person: Person! { get }
}
