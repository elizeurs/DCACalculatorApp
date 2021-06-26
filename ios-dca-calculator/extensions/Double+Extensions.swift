//
//  Double+Extensions.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 24/06/21.
//

import Foundation

extension Double {
  
  var stringValue: String {
    return String(self)
  }
  
  var twoDecimalPlaceString: String {
    return String(format: "%.2f", self)
  }
}
