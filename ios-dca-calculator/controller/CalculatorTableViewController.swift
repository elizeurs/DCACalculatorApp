//
//  CalculatorTableViewController.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 20/06/21.
//

import UIKit

class CalculatorTableViewController: UITableViewController {
  
  @IBOutlet weak var initialInvestmentAmountTextField: UITextField!
  @IBOutlet weak var monthlyDollarCostAveragingTextField: UITextField!
  @IBOutlet weak var initialDateOfInvestmentTextField: UITextField!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet var currencyLabels: [UILabel]!
  @IBOutlet weak var investmentAmountCurrencyLabel: UILabel!
  
  var asset: Asset?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTextFields()
  }
  
  private  func  setupViews() {
    symbolLabel.text = asset?.searchResult.symbol
    nameLabel.text = asset?.searchResult.name
    investmentAmountCurrencyLabel.text = asset?.searchResult.currency
    currencyLabels.forEach { (label) in
      label.text = asset?.searchResult.currency.addBrackets()
//      label.text = "(" + asset!.searchResult.currency + ")"
    }
  }
  
  private func setupTextFields() {
    initialInvestmentAmountTextField.addDoneButton()
    monthlyDollarCostAveragingTextField.addDoneButton()
    initialDateOfInvestmentTextField.delegate = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDateSelection",
       let dateSelectionTableViewController = segue.destination as? DateSelectionTableViewController,
       let timeSeriesMonthlyAdjusted = sender as? TimeSeriesMontlyAdjusted {
      dateSelectionTableViewController.timeSeriesMontlyAdjusted = timeSeriesMonthlyAdjusted
    }
  }
}

extension CalculatorTableViewController: UITextFieldDelegate {
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField == initialDateOfInvestmentTextField {
      performSegue(withIdentifier: "showDateSelection", sender: asset?.timeSeriesMonthlyAdjusted)
    }
    return false
  }
}
