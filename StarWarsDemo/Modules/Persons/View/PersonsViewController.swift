//
//  PersonsViewController.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 24/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

class PersonsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: PersonsViewModel!
    
    private var persons = [Person]()
    private var filteredPersons = [Person]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                detailVC.person = isFiltering ? filteredPersons[indexPath.row] : persons[indexPath.row]
            }
        //}
    }
}

extension PersonsViewController: PersonsViewConfiguration {
    
    internal func configure() {
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
        
        tableView.isHidden = true
        
        tableView.addSubview(myRefreshControl)
        setupSearchController()
    }
    
    internal func reloadData(persons: [Person], next: String?, needsRefreshing: Bool, isCalledOnScroll: Bool) {
        self.persons += persons
        tableView.reloadData()
        if !isCalledOnScroll && needsRefreshing {
            myRefreshControl.endRefreshing()
        }
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    @objc internal func refresh(sender: UIRefreshControl) {
        self.persons.removeAll()
        self.filteredPersons.removeAll()
        self.tableView.reloadData()
        viewModel.requestPersons(needsRefreshing: true, isCalledOnScroll: false)
    }
    
}

extension PersonsViewController: UITableViewDataSourcePrefetching, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let needsFetch = indexPaths.contains { $0.row >= self.persons.count-10 } && !viewModel.hasFinishedDownloading
        if needsFetch {
            viewModel.requestPersons(needsRefreshing: false, isCalledOnScroll: true)
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredPersons.count : persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        let person = isFiltering ? filteredPersons[indexPath.row] : persons[indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.gender.map { $0.rawValue }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = isFiltering ? filteredPersons[indexPath.row] : persons[indexPath.row]
        viewModel.detailDidPress(person: person)
    }
}

extension PersonsViewController: UISearchResultsUpdating {
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.isActive = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = ["All", "male", "female"]
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        guard let titles = searchBar.scopeButtonTitles else { return }
        let scope = titles[searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPersons = persons.filter({ (person: Person) -> Bool in
            
            let doesCategoryMatch = (scope == "All") || (person.gender.map { $0.rawValue } == scope)
            if searchBarIsEmpty {
                return doesCategoryMatch
            }
            return doesCategoryMatch && person.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension PersonsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
