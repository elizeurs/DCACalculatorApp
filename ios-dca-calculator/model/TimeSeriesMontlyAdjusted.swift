//
//  TimeSeriesMontlyAdjusted.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 19/06/21.
//

import Foundation

struct TimeSeriesMontlyAdjusted: Decodable {
  
  let meta: Meta
  let timeSeries: [String: OHLC]
}

struct Meta: Decodable {
  let symbol: String
  
  enum CodingKeys: String, CodingKey {
    case symbol = "2. Symbol"
  }
}

struct OHLC: Decodable {
  let open: String
  let close: String
  let adjustedClose: String
  
  enum CodingKeys: String, CodingKey {
    case open = "1. open"
    case close = "4. close"
    case adjustedClose = "5. adjusted close"
  }
}
