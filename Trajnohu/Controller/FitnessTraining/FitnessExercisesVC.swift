//
//  FitnessExercisesVC.swift
//  Trajnohu
//
//  Created by user226415 on 9/28/22.
//

import UIKit
import CoreData


class FitnessExercisesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var fitnessPlansArray: [FitnessPlan] = []
    var weekDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    @IBOutlet weak var fitnessPlansTV: UITableView!
    @IBOutlet weak var noPlanSW: UIStackView!
    var exercisesArray: [Exercise] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlansTV()
        //getExercises()
        //saveData()
        fetchData()
        createFitnessPlans()
        checkForFitnessPlans()
        print(exercisesArray.count)    }
    
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
    
    func getExercises() {
        ExcercisesRequest.getExercises { exercises, error in
            if let exercises = exercises {
                for i in 0...49 {
                    self.exercisesArray.append(exercises[i])
                }
                self.saveData()
            }
            if let error = error {
                print(error)
            }
        }
    }
    
    func saveData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ExerciseEntity", in: context!)!
        
        for exercise in exercisesArray {
            let exerciseMO = NSManagedObject(entity: entity, insertInto: context!)
            exerciseMO.setValue(exercise.id, forKey: "id")
            exerciseMO.setValue(exercise.name, forKey: "name")
            exerciseMO.setValue(exercise.bodyPart, forKey: "bodyPart")
            exerciseMO.setValue(exercise.target, forKey: "target")
            exerciseMO.setValue(exercise.equipment, forKey: "equipment")
            exerciseMO.setValue(exercise.gifUrl, forKey: "gifUrl")
            exerciseMO.setValue(exercise.day, forKey: "day")
        }
        do {
            try context!.save()
            //fetch data
            print ("Exercises saved succesfully")
        } catch {
            print("Error saving exercises")
        }
    }
    func fetchData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ExerciseEntity")
        
        do {
            let results = try context!.fetch(request)
            for exerciseMO in ((results as? [NSManagedObject])!) {
                var exercise = Exercise()
                exercise.id = (exerciseMO.value(forKey: "id") ?? "") as? String
                exercise.name = (exerciseMO.value(forKey: "name") ?? "") as? String
                exercise.bodyPart = (exerciseMO.value(forKey: "bodyPart") ?? "") as? String
                exercise.target = (exerciseMO.value(forKey: "target") ?? "") as? String
                exercise.equipment = (exerciseMO.value(forKey: "equipment") ?? "") as? String
                exercise.gifUrl = (exerciseMO.value(forKey: "gifUrl") ?? "") as? String
                exercise.day = weekDays.randomElement()
                print(exercise.id ?? "")
                print(exercise.day ?? "")
                exercisesArray.append(exercise)
            }
        } catch {
            print("Could not fetch data.")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !(fitnessPlansArray[indexPath.row].weekdays?.count == 0) else { return }
        //go to plan days, send fitnessPlan
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FitnessPlanDaysViewController") as? FitnessPlanDaysViewController {
            vc.fitnessPlan = fitnessPlansArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func generateRandomPlans(numOfExcercises: Int) -> [Exercise] {
        var exercises: [Exercise] = []
        for _ in 0...numOfExcercises{
            let n = Int.random(in: 0...48)
            print(n)
            exercises.append(exercisesArray[n])
        }
        return exercises
    }
    
    func createFitnessPlans() {
        let plan1 = FitnessPlan(nameOfPlan: "Burn Fat", weekdays: ["Monday", "Wednesday", "Thursday", "Friday"], exercises: generateRandomPlans(numOfExcercises: 8))
        let plan2 = FitnessPlan(nameOfPlan: "Gain Mass", weekdays: ["Monday", "Wednesday", "Friday"], exercises: generateRandomPlans(numOfExcercises: 8))
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
