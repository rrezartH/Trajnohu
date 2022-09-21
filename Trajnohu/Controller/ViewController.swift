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
    var hasStartedOnce: Bool = false
    let defaultAnimationDuration: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateVCs(vC: LoginVC.self, "LoginVC")
        hasStartedOnce = true
    }
    
    @IBAction func swapLoginRegisterBtnPressed(_ sender: Any) {
        swapLoginRegister()
    }
    
    func swapLoginRegister() {
        let previousView = userAccessView.subviews.last
        
        if hasAccount {
            animateView(viewController: previousView!, y: self.userAccessView.frame.height, true)
            self.instantiateVCs(vC: RegisterVC.self, "RegisterVC")
            self.swapLoginRegisterBtn.setTitle("Keni llogari?", for: .normal)
        } else {
            animateView(viewController: previousView!, y: self.userAccessView.frame.height, true)
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
        animateView(viewController: viewController.view, y: 0, false)
        viewController.didMove(toParent: self)
    }
    
    func animateView(viewController: UIView, y: CGFloat, _ removeView: Bool) {
        UIView.animate(withDuration: hasStartedOnce ? defaultAnimationDuration : 0) {
            viewController.frame = CGRect(x: 0, y: y, width: self.userAccessView.frame.width, height: self.userAccessView.frame.height)
        } completion: { _ in
            if removeView {
                viewController.removeFromSuperview()
            }
        }

    }
}

