//
//  ViewController.swift
//  Trajnohu
//
//  Created by user226415 on 9/20/22.
//

import UIKit
import IBAnimatable
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var swapLoginRegisterBtn: AnimatableButton!
    @IBOutlet weak var userAccessView: AnimatableView!
    
    var hasAccount: Bool = true
    var hasStartedOnce: Bool = false
    let defaultAnimationDuration: CGFloat = 0.5
    //TODO: export these in FitnessExercisesVC
    var exercisesArray: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateVCs(vC: LoginVC.self, "LoginVC")
        hasStartedOnce = true
        getExercises()
        saveData()
    }
    
    func getExercises() {
        ExcercisesRequest.getExercises { exercises, error in
            if let exercises = exercises {
                for i in 0...49 {
                    self.exercisesArray.append(exercises[i])
                    print(exercises[i].bodyPart ?? "")
                }
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
            let results = try context?.fetch(request)
            for exerciseMO in ((results as? [NSManagedObject])!) {
                var exercise = Exercise()
                exercise.id = (exerciseMO.value(forKey: "id") ?? "") as? String
                exercise.name = (exerciseMO.value(forKey: "name") ?? "") as? String
                exercise.bodyPart = (exerciseMO.value(forKey: "bodyPart") ?? "") as? String
                exercise.target = (exerciseMO.value(forKey: "target") ?? "") as? String
                exercise.equipment = (exerciseMO.value(forKey: "equipment") ?? "") as? String
                exercise.gifUrl = (exerciseMO.value(forKey: "gifUrl") ?? "") as? String
                exercise.day = (exerciseMO.value(forKey: "day") ?? "") as? String
                exercisesArray.append(exercise)
            }
        } catch {
        
        }
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

