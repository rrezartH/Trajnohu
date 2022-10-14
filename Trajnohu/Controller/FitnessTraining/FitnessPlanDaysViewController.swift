//
//  FitnessPlanDaysViewController.swift
//  Trajnohu
//
//  Created by TDI Student on 14.10.22.
//

import UIKit

class FitnessPlanDaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var daysTableView: UITableView!
    
    var fitnessPlan: FitnessPlan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDaysTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupDaysTableView() {
        daysTableView.delegate = self
        daysTableView.dataSource = self
        daysTableView.register(UINib(nibName: "FitnessPlanDayTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessPlanDayTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fitnessPlan?.weekdays?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessPlanDayTableViewCell") as! FitnessPlanDayTableViewCell
        cell.setDay(day: fitnessPlan?.weekdays?[indexPath.row] ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FitnessDayExerciseViewController") as? FitnessDayExerciseViewController {

            var filteredExercises: [Exercise] = []

            for exercise in fitnessPlan?.exercises ?? [] {
                if exercise.day == fitnessPlan?.weekdays?[indexPath.row] {
                    filteredExercises.append(exercise)
                }
            }
            vc.exercises = filteredExercises
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
