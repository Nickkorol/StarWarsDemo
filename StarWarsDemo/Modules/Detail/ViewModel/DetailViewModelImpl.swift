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
    weak var view: DetailViewInput?
    
    func viewDidLoad() {
        loadPersonData()
    }
    
    func loadPersonData() {
        guard let films = person.films,
            let species = person.species,
            let planet = person.homeworld,
            let vehicles = person.vehicles,
            let starships = person.starships else { return }
        URLSessionAPIManager.shared.getDetailPersonInfo(filmsURLs: films, speciesURLs: species, planetURL: planet, vehiclesURLs: vehicles, starshipsURLs: starships) {[weak self] (films, species, planet, vehicles, starships) in
            self?.prepareDetailText(films: films, species: species, planet: planet, vehicles: vehicles, starships: starships)
        }
    }
    
    func prepareDetailText(films: [Film], species: [Specie], planet: Planet, vehicles: [Vehicle], starships: [Starship]) {
        var finalText: String
        finalText = "Name - \(self.person.name)\n"
        finalText += "Height - \(self.person.height)\n"
        finalText += "Mass - \(self.person.mass)\n"
        finalText += "Hair color - \(self.person.hairColor)\n"
        finalText += "Skin color - \(self.person.skinColor)\n"
        finalText += "Eye color - \(self.person.eyeColor)\n"
        finalText += "Birth year - \(self.person.birthYear)\n"
        if let gender = self.person.gender?.rawValue {
            finalText += "Gender - \(gender)\n"
        }
        
        finalText += "Films - "
        for film in films {
            finalText += film.title + ", "
        }
        finalText.removeLast()
        finalText.removeLast()
        finalText += "\n"
        if species.count > 0 {
            finalText += "Species - "
            for specie in species {
                finalText += specie.name + ", "
            }
            finalText.removeLast()
            finalText.removeLast()
            finalText += "\n"
        }
        finalText += "Home planet - \(planet.name)"
        finalText += "\n"
        if vehicles.count > 0 {
            finalText += "Vehicles - "
            for vehicle in vehicles {
                finalText += vehicle.name + ", "
            }
            finalText.removeLast()
            finalText.removeLast()
            finalText += "\n"
        }
        if starships.count > 0 {
            finalText += "Starships - "
            for starship in starships {
                finalText += starship.name + ", "
            }
            finalText.removeLast()
            finalText.removeLast()
        }
        self.view?.showDetailUserInfo(text: finalText)
        //self.textLabel.text = finalText
        //self.textLabel.isHidden = false
        //self.activityIndicator.stopAnimating()
    }
    
//    func showPersonInfo() -> String {
//        self.loadPersonData()
//        var personText = "Name - \(person.name)\n"
//        guard let gender = person.gender else { return personText }
//        personText += "Gender - \(gender)\n"
//        personText += "Mass - \(person.mass) kg\n"
//        personText += "Height - \(person.height) cm\n"
//        personText += "Hair color - \(person.hairColor)\n"
//        personText += "Eye color - \(person.eyeColor)\n"
//        personText += "Skin color - \(person.skinColor)\n"
//        personText += "Birth year - \(person.birthYear)\n"
////        personText += "Films - "
////        for film in films {
////            personText += "\(film.title)"
////        }
//        personText += "\n"
//        return personText
//    }
    
}
