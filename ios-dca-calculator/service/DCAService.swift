//
//  DCAService.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 24/06/21.
//

import Foundation

struct DCAService {
  
  func calculate(asset: Asset, initialInvestmentAmount: Double, monthlyDollarCostAveragingAmount: Double, initialDateOfInvestmentIndex: Int) -> DCAResult {
    
    let investmentAmount = getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
    
    let latestSharePrice = getLatestSharePrice(asset: asset)
    
    let currentValue =  getCurrentValue(numberOfShares: 100, latestSharePrice: latestSharePrice)
    
    return .init(currentValue: currentValue,
                 investmentAmount: investmentAmount,
                 gain: 0,
                 yield: 0,
                 annualReturn: 0)
    
    // currentValue = numberOfShares (initial + DCA) * latest share price
  }
  
  private func getInvestmentAmount(initialInvestmentAmount: Double,
                                   monthlyDollarCostAveragingAmount: Double,
                                   initialDateOfInvestmentIndex: Int) -> Double {
    var totalAmount = Double()
    totalAmount += initialInvestmentAmount
    let dollarCostAveragingAmount = initialDateOfInvestmentIndex.doubleValue * monthlyDollarCostAveragingAmount
    totalAmount += dollarCostAveragingAmount
    return totalAmount
    
  }
  
  private func getCurrentValue(numberOfShares: Double, latestSharePrice: Double) -> Double {
    return numberOfShares * latestSharePrice
  }
  
  private func getLatestSharePrice(asset: Asset) -> Double {
    return asset.timeSeriesMonthlyAdjusted.getMonthInfos().first?.adjustedClose ?? 0
  }
}

struct DCAResult {
  let currentValue: Double
  let investmentAmount: Double
  let gain: Double
  let yield: Double
  let annualReturn: Double
}
