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
        default:
            return "\(baseURL)"
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
        return Alamofire.request(url!)
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
}
