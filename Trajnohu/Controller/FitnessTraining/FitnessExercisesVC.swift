//
//  FitnessExercisesVC.swift
//  Trajnohu
//
//  Created by user226415 on 9/28/22.
//

import UIKit

class FitnessExercisesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var fitnessPlansArray: [FitnessPlan] = []
    
    @IBOutlet weak var fitnessPlansTV: UITableView!
    @IBOutlet weak var noPlanSW: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlansTV()
        createFitnessPlans()
        checkForFitnessPlans()
    }
    
    func setupPlansTV() {
        fitnessPlansTV.delegate = self
        fitnessPlansTV.dataSource = self
        fitnessPlansTV.register(UINib(nibName: "FitnessPlanCell", bundle: nil), forCellReuseIdentifier: "FitnessPlanCell")
    }
    
    func checkForFitnessPlans() {
        //TODO: Find a better way to hide the stackView
        if fitnessPlansArray.count != 0 {
            noPlanSW.alpha = 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fitnessPlansTV.dequeueReusableCell(withIdentifier: "FitnessPlanCell") as! FitnessPlanCell
        cell.setDetailsFor(plan: fitnessPlansArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fitnessPlansArray.count
    }
    
    func createFitnessPlans() {
        let plan1 = FitnessPlan(nameOfPlan: "Burn Fat", weekdays: ["Monday", "Wednesday", "Friday"])
        let plan2 = FitnessPlan(nameOfPlan: "Burn Fat", weekdays: ["Monday", "Wednesday", "Friday"])
        fitnessPlansArray.append(plan1)
        fitnessPlansArray.append(plan2)
        fitnessPlansArray.append(plan1)
        fitnessPlansArray.append(plan2)
        fitnessPlansArray.append(plan1)
        fitnessPlansArray.append(plan2)
        fitnessPlansArray.append(plan1)
        fitnessPlansArray.append(plan2)
        fitnessPlansTV.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
