//
//  Date+Extensions.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 22/06/21.
//

import Foundation

extension Date {
  
  var MMYYFormat: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    return dateFormatter.string(from: self)
  }
}
