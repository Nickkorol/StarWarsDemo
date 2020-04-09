//
//  URLSessionAPIManager.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

protocol URLSessionAPIManager {
    func getPersonsList(numberOfPage: Int, completion: @escaping([Person], String?)->())
    func getDetailPersonInfo(filmsURLs: [URL], speciesURLs: [URL], planetURL: URL, vehiclesURLs: [URL], starshipsURLs: [URL], completion: @escaping([Film], [Specie], Planet, [Vehicle], [Starship])->())
}
