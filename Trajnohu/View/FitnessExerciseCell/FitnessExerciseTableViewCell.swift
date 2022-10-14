//
//  FitnessExerciseTableViewCell.swift
//  Trajnohu
//
//  Created by TDI Student on 14.10.22.
//

import UIKit
import SwiftGifOrigin

class FitnessExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exerciseGifImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetails(exercise: Exercise) {
        nameLabel.text = exercise.name
        bodyPartLabel.text = exercise.bodyPart
        targetLabel.text = exercise.target
        equipmentLabel.text = exercise.equipment
        
        exerciseGifImageView.image = UIImage.gifImageWithURL(exercise.gifUrl ?? "")
        //print("\(exercise.gifUrl) ")
    }
    
}
