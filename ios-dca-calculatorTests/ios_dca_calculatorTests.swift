//
//  ios_dca_calculatorTests.swift
//  ios-dca-calculatorTests
//
//  Created by Elizeu RS on 07/07/21.
//

import XCTest
@testable import ios_dca_calculator

class ios_dca_calculatorTests: XCTestCase {
  
  var sut: DCAService!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = DCAService()
      
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
      sut = nil
      
        // Put teardown code here. This method is called after the invocation of each test method Ain the class.
    }
  
  // test cases
  // 1. asset = winning | dca = true
  // 2. asset = winning | dca = false
  // 3. asset = losing | dca = true
  // 4. asset = losing | dca = false
  
  // format for test function name
  // what
  // given
  // expectation
  
  func testDCAResult_givenDollarCostAveragingIsUsed_expectResult() {
    
  }
  
  func testDCAResult_givenDollarCostAveragingIsNotUsed_expectResult() {
    
  }
  
  func testInvestment_whenDCAIsUsed_expectResult() {
    // given
    let initialInvestmentAmount: Double = 500
    let monthlyDollarCostAveragingAmount: Double = 300
    let initialDateOfInvestmentIndex = 4 // (5 months ago)
    // when
    let investmentAmount = sut.getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
    // then
    XCTAssertEqual(investmentAmount, 1700)
    // Initial Amount: $500
    // DCA: 4 X $399 = $1200
    // total: $1200 + $500 = $1700
    
  }
  
  func testInvestmentAmount_whenDCAIsNotUsed_expectResult() {
    // given
    let initialInvestmentAmount: Double = 500
    let monthlyDollarCostAveragingAmount: Double = 0
    let initialDateOfInvestmentIndex = 4 // (5 months ago)
    // when
    let investmentAmount = sut.getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
    // then
    XCTAssertEqual(investmentAmount, 500)
    // Initial Amount: $500
    // DCA: 4 X $0 = $0
    // total: $0 + $500 = $500
  }

    func testExample() throws {
      
      // given
      let num1 = 5
      let num2 = 21
      
      // when
      let result = sut.performSubtraction(num1: num1, num2: num2)
      
      // then
      XCTAssertEqual(result, 3)
      XCTAssertTrue(result > 0)
      
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
  
  func testExample2() {
    // given
    let num1 = 1
    let num2 = 2
    // when
    let result = performAddition(num1: num1, num2: num2)
    // then
    XCTAssertEqual(result, 3)
  }
  
  func performAddition(num1: Int, num2: Int) -> Int {
    return num1 + num2
  }

}
