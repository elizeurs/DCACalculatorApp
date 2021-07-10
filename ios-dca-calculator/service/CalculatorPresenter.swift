//
//  CalculatorPresenter.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 10/07/21.
//

import UIKit

struct CalculatorPresenter {
  func getPresentation(result: DCAResult) -> CalculatorPresentation {
    
    let isProfitable = result.isProfitable == true
    let gainSymbol = isProfitable ?  "+" : ""
    
    return .init (currentValueLabelBackgroundColor: isProfitable ? .themeGreenShade : .themeRedShade,
                  currentValue: result.currentValue.currencyFormat,
                  investmentAmount: result.investmentAmount.toCurrencyFormat(hasDecimalPlaces: false),
                  gain: result.gain.toCurrencyFormat(hasDollarSymbol: true, hasDecimalPlaces: false).prefix(withText: gainSymbol),
                  yield: result.yield.percentageFormat.prefix(withText: gainSymbol).addBrackets(),
                  yieldLabelTextColor: isProfitable ? .systemGreen : .systemRed,
                  annualReturn: result.annualReturn.percentageFormat,
                  annualReturnLabelTextColor: isProfitable ? .systemGreen : .systemRed)
  }
}

struct CalculatorPresentation {
  let currentValueLabelBackgroundColor: UIColor
  let currentValue: String
  let investmentAmount: String
  let gain: String
  let yield: String
  let yieldLabelTextColor: UIColor
  let annualReturn: String
  let annualReturnLabelTextColor: UIColor
  
//  self?.currentValueLabel.backgroundColor = isProfitable ? .themeGreenShade : .themeRedShade
//  self?.currentValueLabel.text = result?.currentValue.currencyFormat
//  self?.investmentAmountLabel.text = result?.investmentAmount.toCurrencyFormat(hasDecimalPlaces: false)
//  self?.gainLabel.text = result?.gain.toCurrencyFormat(hasDollarSymbol: true, hasDecimalPlaces: false).prefix(withText: gainSymbol)
//  self?.yieldLabel.text = result?.yield.percentageFormat.prefix(withText: gainSymbol).addBrackets()
//  self?.yieldLabel.textColor = isProfitable ? .systemGreen : .systemRed
//  self?.annualReturnLabel.text = result?.annualReturn.percentageFormat
//  self?.annualReturnLabel.textColor = isProfitable ? .systemGreen : .systemRed
}
