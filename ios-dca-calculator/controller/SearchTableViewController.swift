//
//  ViewController.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 07/06/21.
//

import UIKit
import Combine
import MBProgressHUD // lottie animation

class SearchTableViewController: UITableViewController, UIAnimatable {
  
  private enum Mode {
    case onboading
    case search
  }
  
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
  @Published private var mode: Mode = .onboading
  @Published private var searchQuery = String()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupNavigationBar()
    setupTableView()
    observeForm()
//    performSearch()
  }
  
  private func setupNavigationBar() {
    navigationItem.searchController = searchController
    navigationItem.title = "Search"
  }
  
  func setupTableView() {
    tableView.isScrollEnabled = false
    tableView.tableFooterView = UIView()
  }
  
  private func observeForm() {
    
    $searchQuery
      .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
      .sink { [unowned self] (searchQuery) in
        guard !searchQuery.isEmpty else { return }
        showLoadingAnimation()
        self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { (completion) in
          hideLoadingAnimation()
          switch completion {
          case .failure(let error):
            print(error.localizedDescription)
          case .finished: break
          }
        } receiveValue: { (searchResults) in
//          print(searchResults)
          self.searchResults = searchResults
          self.tableView.reloadData()
          self.tableView.isScrollEnabled = true
        }.store(in: &self.subscribers)
      }.store(in: &subscribers)
    
    $mode.sink { (mode) in
      switch mode {
      case .onboading:
        self.tableView.backgroundView = SearchPlaceholderView()
//        let redView = UIView()
//        redView.backgroundColor = .red
//        self.tableView.backgroundView = redView
      case .search:
        self.tableView.backgroundView = nil
      }
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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let searchResults = self.searchResults {
      let searchResult = searchResults.items[indexPath.item]
      let symbol = searchResults.items[indexPath.item].symbol
      handleSelection(for: symbol, searchResult: searchResult)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  private func handleSelection(for symbol: String, searchResult: SearchResult) {
    showLoadingAnimation()
    apiService.fetchTimeSeriesMonthlyAdjustedPublisher(keywords: symbol).sink { [weak self] (completionResult) in
      self?.hideLoadingAnimation()
      switch completionResult {
      case .failure(let error):
        print(error)
      case .finished: break
      }
    } receiveValue: { [weak self] (timeSeriesMonthlyAdjusted) in
      self?.hideLoadingAnimation()
      let asset = Asset(searchResult: searchResult, timeSeriesMonthlyAdjusted: timeSeriesMonthlyAdjusted)
      self?.performSegue(withIdentifier: "showCalculator", sender: asset)
//      print("success: \(timeSeriesMonthlyAdjusted.getMonthInfos())")
      self?.searchController.searchBar.text = nil
    }.store(in: &subscribers)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showCalculator",
       let destination = segue.destination as? CalculatorTableViewController,
       let asset = sender as? Asset {
      destination.asset = asset
    }
  }
}


extension SearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchQuery  =  searchController.searchBar.text, !searchQuery.isEmpty else { return }
    self.searchQuery = searchQuery
  }
  
  func willPresentSearchController(_ searchController: UISearchController) {
//    print("will present")
    mode = .search
  }
}

