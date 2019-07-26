//
//  Specie.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

struct Specie: Codable {
    let name, classification, designation, averageHeight: String
    let skinColors, hairColors, eyeColors, averageLifespan: String
    let homeworld: URL?
    let language: String
    let people, films: [URL]?
    let created, edited: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case name, classification, designation
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case homeworld, language, people, films, created, edited, url
    }
}
