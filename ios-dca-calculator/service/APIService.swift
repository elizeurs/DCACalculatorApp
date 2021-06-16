//
//  APIService.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 16/06/21.
//

import Foundation
import Combine

struct APIService {
  
//  let API_KEY = "KN8XNH79103W3HIH"
//  let API_KEY2 = "OZLTAABH40S1CV08"
//  let API_KEY3 = "W1BDQQPOLJFCZN53"
  
  var API_KEY: String {
    return keys.randomElement() ?? ""
  }
  
  let keys = ["KN8XNH79103W3HIH", "OZLTAABH40S1CV08", "W1BDQQPOLJFCZN53"]
  
  func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
    
    let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
    
    let url = URL(string: urlString)!
    
    return  URLSession.shared.dataTaskPublisher(for: url)
      .map({ $0.data })
      .decode(type: SearchResults.self, decoder: JSONDecoder())
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
