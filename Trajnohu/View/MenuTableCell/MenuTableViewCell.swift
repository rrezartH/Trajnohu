//
//  MenuTableViewCell.swift
//  Trajnohu
//
//  Created by user226415 on 10/2/22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var pageNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPageName(_ pageName: String) {
        pageNameLabel.text = pageName
    }
    
}
