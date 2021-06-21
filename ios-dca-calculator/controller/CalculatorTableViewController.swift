//
//  CalculatorTableViewController.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 20/06/21.
//

import UIKit

class CalculatorTableViewController: UITableViewController {
  
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet var currencyLabels: [UILabel]!
  
  var asset: Asset?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  private  func  setupViews() {
    symbolLabel.text = asset?.searchResult.symbol
    nameLabel.text = asset?.searchResult.name
    currencyLabels.forEach { (label) in
      label.text = asset?.searchResult.currency.addBrackets()
//      label.text = "(" + asset!.searchResult.currency + ")"
    }
  }
}
