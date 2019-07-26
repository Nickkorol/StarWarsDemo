//
//  People.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

struct People: Codable {
    let count: Int
    let next, previous: String?
    let results: [Person]
}
