//
//  PersonsViewModelImpl.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 25/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

final class PersonsViewModelImpl: PersonsViewModel {
    var coordinator: PersonsCoordinator!
    var numberOfPage = 0
    internal var hasFinishedDownloading = false
    private var isLoading = false
    
    weak var view: PersonsViewInput?
    
    func viewDidLoad() {
        requestPersons(needsRefreshing: false, isCalledOnScroll: false)
    }
    
    func detailDidPress(person: Person) {
        coordinator.showDetail(person: person)
    }
    
    func requestPersons(needsRefreshing: Bool, isCalledOnScroll: Bool) {
        guard !isLoading else { return }
        isLoading = true
        if needsRefreshing {
            hasFinishedDownloading = false
            numberOfPage = 0
        }
        numberOfPage += 1
        URLSessionAPIManager.shared.getPersonsList(numberOfPage: numberOfPage) {[weak self] (persons, next) in
            self?.view?.reloadData(persons: persons,
                                         next: next,
                                         needsRefreshing: needsRefreshing,
                                         isCalledOnScroll: isCalledOnScroll)
            if next == nil && isCalledOnScroll {
                self?.view?.hideInfiniteLoading()
                self?.hasFinishedDownloading = true
            }
            self?.isLoading = false
        }
    }
    
}
