//
//  DateSelectionTableViewController.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 22/06/21.
//

import UIKit

class DateSelectionTableViewController: UITableViewController {
  
  var timeSeriesMontlyAdjusted: TimeSeriesMontlyAdjusted?
  var selectedIndex: Int?
  
  private var monthInfos: [MonthInfo] = []
  
  var didSelectDate: ((Int) -> Void)?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMonthInfos()
    setupNavigation()
  }
  
  private func setupNavigation() {
    title = "Select date"
  }
  
  private func setupMonthInfos() {
    monthInfos = timeSeriesMontlyAdjusted?.getMonthInfos() ?? []
//    if let monthInfos = timeSeriesMontlyAdjusted?.getMonthInfos() {
//      self.monthInfos = monthInfos
//    }
  }
}

extension DateSelectionTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return timeSeriesMontlyAdjusted?.getMonthInfos().count ?? 0
    return monthInfos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DateSelectionTableViewCell
    let index = indexPath.item
    let monthInfo = monthInfos[index]
    let isSelected = index  == selectedIndex
    cell.configure(with: monthInfo, index: index, isSelected: isSelected)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    didSelectDate?(indexPath.item)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

class DateSelectionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var monthLabel: UILabel!
  @IBOutlet weak var monthsAgoLabel: UILabel!
  
  func configure(with monthInfo: MonthInfo, index: Int, isSelected: Bool) {
//    backgroundColor = .red
    
    monthLabel.text = monthInfo.date.MMYYFormat
    accessoryType = isSelected ? .checkmark : .none
    if index == 1 {
      monthsAgoLabel.text = "1 month ago"
    } else if index > 1 {
      monthsAgoLabel.text = "\(index) months ago"
    } else {
      monthsAgoLabel.text = "Just invested"
    }
  }
}
