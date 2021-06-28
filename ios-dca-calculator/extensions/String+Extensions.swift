//
//  String+Extensions.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 21/06/21.
//

import Foundation

extension String {
  
  func addBrackets() -> String {
    return "(\(self))"
  }
  
  func prefix(withText text: String) -> String {
    return text + self
  }
}
