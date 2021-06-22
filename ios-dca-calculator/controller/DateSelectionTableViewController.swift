//
//  DateSelectionTableViewController.swift
//  ios-dca-calculator
//
//  Created by Elizeu RS on 22/06/21.
//

import UIKit

class DateSelectionTableViewController: UITableViewController {
  
  var timeSeriesMontlyAdjusted: TimeSeriesMontlyAdjusted?
  var monthInfos: [MonthInfo] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMonthInfos()
  }
  
  private func setupMonthInfos() {
    if let monthInfos = timeSeriesMontlyAdjusted?.getMonthInfos() {
      self.monthInfos = monthInfos
    }
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
    cell.configure(with: monthInfo, index: index)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

class DateSelectionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var monthLabel: UILabel!
  @IBOutlet weak var monthsAgoLabel: UILabel!
  
  func configure(with monthInfo: MonthInfo, index: Int) {
//    backgroundColor = .red
    
    monthLabel.text = monthInfo.date.MMYYFormat
    if index == 1 {
      monthsAgoLabel.text = "1 month ago"
    } else if index > 1 {
      monthsAgoLabel.text = "\(index) months ago"
    } else {
      monthsAgoLabel.text = "Just invested"
    }
  }
}
