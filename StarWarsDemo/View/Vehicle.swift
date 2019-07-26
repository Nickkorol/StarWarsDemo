//
//  Vehicle.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

// MARK: - Planet
struct Vehicle: Codable {
    let name, model, manufacturer, costInCredits: String
    let length, maxAtmospheringSpeed, crew, passengers: String
    let cargoCapacity, consumables, vehicleClass: String
    let pilots, films: [URL]?
    let created, edited: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case vehicleClass = "vehicle_class"
        case pilots, films, created, edited, url
    }
}
