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
        if let data = UserDefaults.standard.object(forKey: person.name) as? Data {
            do {
                let textData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                guard let text = textData as? String else { return }
                self.view?.showDetailUserInfo(text: text)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            URLSessionAPIManagerImpl.shared.getDetailPersonInfo(filmsURLs: films, speciesURLs: species, planetURL: planet, vehiclesURLs: vehicles, starshipsURLs: starships) {[weak self] (films, species, planet, vehicles, starships) in
                self?.prepareDetailText(films: films, species: species, planet: planet, vehicles: vehicles, starships: starships)
            }
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
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: finalText, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: person.name)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.view?.showDetailUserInfo(text: finalText)
    }
    
}
