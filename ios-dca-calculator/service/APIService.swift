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
  
  enum APIServiceError: Error {
    case encoding
    case badRequest
  }
  
  var API_KEY: String {
    return keys.randomElement() ?? ""
  }
  
  let keys = ["KN8XNH79103W3HIH", "OZLTAABH40S1CV08", "W1BDQQPOLJFCZN53"]
  
  func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
    
    let result = parseQuery(text: keywords)
    var symbol = String()
    
    switch result {
    case .success(let query):
      symbol = query
    case .failure(let error):
      return Fail(error: error).eraseToAnyPublisher()
    }
    
    
//    guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
//      return Fail(error: APIServiceError.encoding).eraseToAnyPublisher() }
    
    let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
    let urlResult = parseURL(urlString: urlString)

    
    switch urlResult {
    case .success(let url):
      return  URLSession.shared.dataTaskPublisher(for: url)
        .map({ $0.data })
        .decode(type: SearchResults.self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    case .failure(let error):
      return Fail(error: error).eraseToAnyPublisher()
    }
  }
  
  func fetchTimeSeriesMonthlyAdjustedPublisher(keywords: String) -> AnyPublisher<TimeSeriesMontlyAdjusted, Error> {
    
    let result = parseQuery(text: keywords)
    
    var symbol = String()
    
    switch result {
    case .success(let query):
      symbol = query
    case .failure(let error):
      return Fail(error: error).eraseToAnyPublisher()
    }
    
//    guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
//      return Fail(error: APIServiceError.encoding).eraseToAnyPublisher() }
    
    
    let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(keywords)&apikey=\(API_KEY)"
    
    let urlResult = parseURL(urlString: urlString)
    
    switch urlResult {
    case .success(let url):
      return  URLSession.shared.dataTaskPublisher(for: url)
        .map({ $0.data })
        .decode(type: TimeSeriesMontlyAdjusted.self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    case .failure(let error):
      return Fail(error: error).eraseToAnyPublisher()
    }
  }
  
  private func parseQuery(text: String) -> Result<String, Error> {
    if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
      return .success(query)
    } else {
      return .failure(APIServiceError.encoding)
    }
  }
  
  private func parseURL(urlString: String) -> Result<URL, Error> {
    if let url = URL(string: urlString) {
      return .success(url)
    } else {
      return .failure(APIServiceError.badRequest)
    }
  }
}
