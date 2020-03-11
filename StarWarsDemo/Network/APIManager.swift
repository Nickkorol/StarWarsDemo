//
//  APIManager.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import Alamofire

protocol finalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: DataRequest { get }
}

enum LinkType: finalURLPoint {
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
    
    var request: DataRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return Alamofire.request(url!)
    }
    
}

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
        
    var url: URL? {
        return URL(string: "https://swapi.co/")
    }
    
    var request: DataRequest {
        return Alamofire.request(url!, method: .post, parameters: nil, encoding: JSONEncoding.default)
    }
    var next: String?
    
    func sendRequest(numberOfPage: Int, completion: @escaping([Person], String?)->()) {
        let request = LinkType.Person(page: numberOfPage).request
        request.responseJSON { (response) in
            var persons = [Person]()
            
            guard response.result.isSuccess else {
                print("Error in response \(String(describing: response.result.error))")
                return
            }
            do {
                debugPrint(numberOfPage)
                let result = try JSONDecoder().decode(People.self, from: response.data!)
                persons = result.results
                guard let pageString = result.next else {
                    self.next = nil
                    completion(persons,nil)
                    return                    
                }
                self.next = pageString
            } catch {
                print(error)
            }
            completion(persons, self.next)
        }
    }
    
    func sendRequestForFilms(filmsURLs: [URL], speciesURLs: [URL], completion: @escaping([Film],[Specie])->()) {
        DispatchQueue.global(qos: .userInitiated).async {
            var films = [Film]()
            var species = [Specie]()
            let downloadGroup = DispatchGroup()
            for url in filmsURLs {
                downloadGroup.enter()
                let request = LinkType.Film(url: url).request
                request.responseJSON { (response) in
                    guard response.result.isSuccess else {
                        print("Error in response \(String(describing: response.result.error))")
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode(Film.self, from: response.data!)
                        films.append(result)
                        downloadGroup.leave()
                    }
                    catch {
                        print(error)
                    }
                }
            }
            for url in speciesURLs {
                downloadGroup.enter()
                let request = LinkType.Species(url: url).request
                request.responseJSON { (response) in
                    guard response.result.isSuccess else {
                        print("Error in response \(String(describing: response.result.error))")
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode(Specie.self, from: response.data!)
                        species.append(result)
                        downloadGroup.leave()
                    }
                    catch {
                        print(error)
                    }
                }
            }
            downloadGroup.wait()
            completion(films,species)
        }
    }
}
