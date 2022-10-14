//
//  FitnessPlanDayTableViewCell.swift
//  Trajnohu
//
//  Created by TDI Student on 14.10.22.
//

import UIKit

class FitnessPlanDayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDay(day: String) {
        dayLabel.text = day
    }
    
}
