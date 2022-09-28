//
//  FitnessPlanCell.swift
//  Trajnohu
//
//  Created by user226415 on 9/28/22.
//

import UIKit

class FitnessPlanCell: UITableViewCell {

    @IBOutlet weak var weekDays: UILabel!
    @IBOutlet weak var nameOfPlan: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetailsFor(plan: FitnessPlan) {
        nameOfPlan.text = plan.nameOfPlan
        weekDays.text = "\(plan.weekdays?.count ?? 0)"
    }
    
}
