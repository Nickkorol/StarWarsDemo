//
//  Person.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let gender: PersonGender?
    let homeworld: URL?
    let films, species, vehicles, starships: [URL]?
    let created, edited: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

enum PersonGender: String, Codable {
    case male = "male"
    case female = "female"
    case unknown = "n/a"
    case none = "none"
    case hermaphrodite = "hermaphrodite"
}
