//
//  FitnessDayExerciseViewController.swift
//  Trajnohu
//
//  Created by TDI Student on 14.10.22.
//

import UIKit

class FitnessDayExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayPlanTableView: UITableView!
    
    var exercises: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDayPlanTableView()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayPlanTableView.dequeueReusableCell(withIdentifier: "FitnessExerciseTableViewCell") as! FitnessExerciseTableViewCell
        cell.setDetails(exercise: exercises[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func setupDayPlanTableView() {
        dayPlanTableView.dataSource = self
        dayPlanTableView.delegate = self
        dayPlanTableView.register(UINib(nibName: "FitnessExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: "FitnessExerciseTableViewCell")
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
