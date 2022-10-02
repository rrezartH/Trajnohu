//
//  MainPageVC.swift
//  Trajnohu
//
//  Created by user226415 on 10/2/22.
//

import UIKit
import IBAnimatable

class MainPageVC: UIViewController {

    @IBOutlet var mainPageView: UIView!
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var menuButton: AnimatableButton!
    
    var isMenuShown: Bool = false
    var menuWidth: CGFloat = 0.0
    var menuItemArray: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
        createMenuItems()
        setupMenuTable()
        swipeToShowMenu()
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        if !isMenuShown {
            setMenuFrame(x: 0, duration: 0.3)
            isMenuShown = true
        } else {
            setMenuFrame(x: -menuWidth, duration: 0.3)
            isMenuShown = false
        }
    }
    
    func setupMenu() {
        self.view.addSubview(menuView)
        menuWidth = 2 / 3 * self.view.frame.width
        setMenuFrame(x: -menuWidth, duration: 0)
    }
    
    func swipeToShowMenu() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(showMenuBySwipe))
        swipe.direction = .right
        mainPageView.addGestureRecognizer(swipe)
    }
    
    @objc func showMenuBySwipe() {
        setMenuFrame(x: 0, duration: 0.3)
        isMenuShown = true
    }
    
    func setMenuFrame(x: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration) {
            self.menuView.frame = CGRect(x: x, y: 0, width: self.menuWidth, height: self.view.frame.height)
        }
    }
    
    func createMenuItems() {
        let item1 = MenuItem(pageName: "Ballina")
        let item2 = MenuItem(pageName: "Profili")
        let item3 = MenuItem(pageName: "Settings")
        let item4 = MenuItem(pageName: "Log Out")
        
        menuItemArray.append(item1)
        menuItemArray.append(item2)
        menuItemArray.append(item3)
        menuItemArray.append(item4)
        
        menuTable.reloadData()
    }
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func setupMenuTable() {
        menuTable.delegate = self
        menuTable.dataSource = self
        menuTable.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.setPageName(menuItemArray[indexPath.row].pageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleMenuSwipe))
        swipe.direction = .left
        menuTable.addGestureRecognizer(swipe)
    }
    
    @objc func handleMenuSwipe() {
        setMenuFrame(x: -menuWidth, duration: 0.3)
        isMenuShown = false
    }
    
}
