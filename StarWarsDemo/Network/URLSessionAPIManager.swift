//
//  URLSessionAPIManager.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 05.03.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol newFinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var url: URL { get }
}

enum NewLinkType: newFinalURLPoint {
    case Person(page: Int)
    case Planet(url: URL)
    case Film(url: URL)
    case Species(url: URL)
    case Vehicle(url: URL)
    case Starship(url: URL)
    
    var baseURL: URL {
        return URL(string: "https://swapi.co")!
    }
    var path: String {
        switch self {
        case .Person(let page):
            return "/api/people/?page=\(page)"
        case .Planet(let url):
            return "\(url)"
        case .Film(let url):
            return "\(url)"
        case .Species(let url):
            return "\(url)"
        case .Vehicle(let url):
            return "\(url)"
        case .Starship(let url):
            return "\(url)"
        }
    }
    
    var url: URL {
        let url = URL(string: path, relativeTo: baseURL)
        return url!
    }
    
}

class URLSessionAPIManager {
    
    static let shared = URLSessionAPIManager()
    
    private init() {}
    
    let defaultSession = URLSession.shared
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var next: String?
    
    func getPersonsList(numberOfPage: Int, completion: @escaping([Person], String?)->()) {
        
        let url = NewLinkType.Person(page: numberOfPage).url
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage += "Datatask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                var persons = [Person]()
                do {
                    debugPrint(numberOfPage)
                    let result = try JSONDecoder().decode(People.self, from: data)
                    persons = result.results
                    guard let pageString = result.next else {
                        self?.next = nil
                        DispatchQueue.main.async {
                            completion(persons,nil)
                        }
                        return
                    }
                    self?.next = pageString
                } catch {
                    print(error)
                }
                DispatchQueue.main.async {
                    completion(persons, self?.next)
                }
            }
        }
        dataTask?.resume()        
    }
    
    func getDetailPersonInfo(filmsURLs: [URL], speciesURLs: [URL], planetURL: URL, vehiclesURLs: [URL], starshipsURLs: [URL], completion: @escaping([Film], [Specie], Planet, [Vehicle], [Starship])->()) {
        DispatchQueue.global(qos: .userInitiated).async {
            var films = [Film]()
            var species = [Specie]()
            var planet: Planet?
            var vehicles = [Vehicle]()
            var starships = [Starship]()
            let downloadGroup = DispatchGroup()
            
            downloadGroup.enter()
            self.dataTask = self.defaultSession.dataTask(with: planetURL) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                if let error = error {
                    self?.errorMessage += "Datatask error: " + error.localizedDescription + "\n"
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do {
                        let result = try JSONDecoder().decode(Planet.self, from: data)
                        planet = result
                        downloadGroup.leave()
                    }
                    catch {
                        print(error)
                    }
                }
            }
            self.dataTask?.resume()
            
            for url in filmsURLs {
                downloadGroup.enter()
                self.dataTask = self.defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        self?.errorMessage += "Datatask error: " + error.localizedDescription + "\n"
                    } else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        do {
                            let result = try JSONDecoder().decode(Film.self, from: data)
                            films.append(result)
                            downloadGroup.leave()
                        }
                        catch {
                            print(error)
                        }
                    }
                }
                self.dataTask?.resume()
            }
            
            for url in vehiclesURLs {
                downloadGroup.enter()
                
                self.dataTask = self.defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        self?.errorMessage += "Datatask error: " + error.localizedDescription + "\n"
                    } else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        do {
                            let result = try JSONDecoder().decode(Vehicle.self, from: data)
                            vehicles.append(result)
                            downloadGroup.leave()
                        }
                        catch {
                            print(error)
                        }
                    }
                }
                self.dataTask?.resume()
            }
            
            for url in starshipsURLs {
                downloadGroup.enter()
                
                self.dataTask = self.defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        self?.errorMessage += "Datatask error: " + error.localizedDescription + "\n"
                    } else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        do {
                            let result = try JSONDecoder().decode(Starship.self, from: data)
                            starships.append(result)
                            downloadGroup.leave()
                        }
                        catch {
                            print(error)
                        }
                    }
                }
                self.dataTask?.resume()
            }

            downloadGroup.wait()
            DispatchQueue.main.async {
                completion(films, species, planet!, vehicles, starships)
            }
        }
    }
}
