//
//  ViewController.swift
//  Trajnohu
//
//  Created by user226415 on 9/20/22.
//

import UIKit
import IBAnimatable

class ViewController: UIViewController {
    
    @IBOutlet weak var swapLoginRegisterBtn: AnimatableButton!
    @IBOutlet weak var userAccessView: AnimatableView!
    
    var hasAccount: Bool = true
    let defaultAnimationDuration: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateVCs(vC: LoginVC.self, "LoginVC")
    }
    
    @IBAction func swapLoginRegisterBtnPressed(_ sender: Any) {
        swapLoginRegister()
    }
    
    func swapLoginRegister() {
        let previousView = userAccessView.subviews.last
        
        if hasAccount {
            UIView.animate(withDuration: defaultAnimationDuration) {
                previousView?.frame = CGRect(x: 0, y: self.userAccessView.frame.height, width: self.userAccessView.frame.width, height: self.userAccessView.frame.height)
            } completion: { _ in
                previousView?.removeFromSuperview()
            }
            self.instantiateVCs(vC: RegisterVC.self, "RegisterVC")
            self.swapLoginRegisterBtn.setTitle("Keni llogari?", for: .normal)
            
        } else {
            UIView.animate(withDuration: defaultAnimationDuration) {
                previousView?.frame = CGRect(x: 0, y: self.userAccessView.frame.height, width: self.userAccessView.frame.width, height: self.userAccessView.frame.height)
            } completion: { _ in
                previousView?.removeFromSuperview()
            }
            self.instantiateVCs(vC: LoginVC.self, "LoginVC")
            self.swapLoginRegisterBtn.setTitle("Nuk keni llogari?", for: .normal)
        }
        hasAccount = !hasAccount
    }
    
    func instantiateVCs<T: UIViewController>(vC: T.Type , _ identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        addUserAccessView(viewController: viewController)
    }
    
    func addUserAccessView(viewController: UIViewController) {
        self.addChild(viewController)
        viewController.view.frame = CGRect(x: 0, y: -userAccessView.frame.height, width: userAccessView.frame.width, height: userAccessView.frame.height)
        self.userAccessView.addSubview(viewController.view)
        
        UIView.animate(withDuration: defaultAnimationDuration) {
            viewController.view.frame = CGRect(x: 0, y: 0, width: self.userAccessView.frame.width, height: self.userAccessView.frame.height)
        }
        viewController.didMove(toParent: self)
    }
}

