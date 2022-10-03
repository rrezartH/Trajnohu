//
//  MotivationViewController.swift
//  Trajnohu
//
//  Created by TDI Student on 3.10.22.
//

import UIKit

class MotivationViewController: UIViewController {

    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    var imagesArray: [Motivation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createImages()
        setupHorizontalScrollView()
    }
    
    func setupHorizontalScrollView() {
            for i in 0...imagesArray.count - 1 {
            let motivationImageView = UIImageView()
            motivationImageView.frame = CGRect(x: CGFloat(i) * self.view.frame.width, y: 0, width: self.view.frame.width, height: horizontalScrollView.frame.height)
            motivationImageView.image = UIImage(named: imagesArray[i].image ?? " ")
    
            let titleLabel = UILabel()
            titleLabel.text = imagesArray[i].title ?? ""
            titleLabel.backgroundColor = .lightGray
            titleLabel.alpha = 0.7
            titleLabel.frame = CGRect(x: (CGFloat(i) * self.view.frame.width) + 20, y: horizontalScrollView.frame.height - 50 - 20, width: self.view.frame.width - 40, height: 50)
            
            horizontalScrollView.addSubview(motivationImageView)
            horizontalScrollView.addSubview(titleLabel)
    
        }
        horizontalScrollView.contentSize = CGSize(width: CGFloat(imagesArray.count) * self.view.frame.width, height: 300)

    }
    func createImages() {
        
        let motivationImage1 = Motivation(image: "fitnes1", title: "GYM")
        let motivationImage2 = Motivation(image: "fitnes2", title: "GYM")
        let motivationImage3 = Motivation(image: "fitnes3", title: "GYM")

        imagesArray.append(motivationImage1)
        imagesArray.append(motivationImage2)
        imagesArray.append(motivationImage3)
        
        imagesArray += imagesArray
        
    }
}
