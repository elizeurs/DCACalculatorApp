//
//  ViewController.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 07/06/21.
//

import UIKit
import Combine

class SearchTableViewController: UITableViewController {
  
  private lazy var searchController: UISearchController = {
    let sc = UISearchController(searchResultsController: nil)
    sc.searchResultsUpdater = self
    sc.delegate = self
    sc.obscuresBackgroundDuringPresentation = false
    sc.searchBar.placeholder = "Enter a company name or symbol"
    sc.searchBar.autocapitalizationType = .allCharacters
    return sc
  }()
  
  private let apiService = APIService()
  private var subscribers = Set<AnyCancellable>()
  private var searchResults: SearchResults?
  @Published private var searchQuery = String()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupNavigationBar()
    observeForm()
//    performSearch()
  }
  
  private func setupNavigationBar() {
    navigationItem.searchController = searchController
  }
  
  private func observeForm() {
    
    $searchQuery
      .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
      .sink { [unowned self] (searchQuery) in
        
        
        self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { (completion) in
          switch completion {
          case .failure(let error):
            print(error.localizedDescription)
          case .finished: break
          }
        } receiveValue: { (searchResults) in
//          print(searchResults)
          self.searchResults = searchResults
          self.tableView.reloadData()
        }.store(in: &self.subscribers)
      }.store(in: &subscribers)
  }
  
//  private func performSearch() {
//
//  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults?.items.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let  cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchTableViewCell
    if let searchResults = self.searchResults {
      let searchResult = searchResults.items[indexPath.row]
      cell.configure(with: searchResult)
    }
    return cell
  }
}

extension SearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchQuery  =  searchController.searchBar.text, !searchQuery.isEmpty else { return }
    self.searchQuery = searchQuery
  }
}

