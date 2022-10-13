//
//  Exercise.swift
//  Trajnohu
//
//  Created by user226415 on 9/29/22.
//

import Foundation
import SwiftyJSON

class Exercise: NSObject {
    var id: String?
    var name: String?
    var target: String?
    var bodyPart: String?
    var equipment: String?
    var day: String?
    var gifUrl: String?
    
    static func transform(json: JSON) -> Exercise? {
        let exercise = Exercise()
        
        if let id = json["id"].string {
            exercise.id = id
        }
        if let name = json["name"].string {
            exercise.name = name
        }
        if let target = json["target"].string {
            exercise.target = target
        }
        if let bodyPart = json["bodyPart"].string {
            exercise.bodyPart = bodyPart
        }
        if let equipment = json["equipment"].string {
            exercise.equipment = equipment
        }
        if let day = json["day"].string {
            exercise.day = day
        }
        if let gifUrl = json["gifUrl"].string {
            exercise.gifUrl = gifUrl
        }
        
        return exercise
    }
    
    static func transform(jsonArray: [JSON]) -> [Exercise]? {
        var exercisesArray: [Exercise] = []
        for jsonObject in jsonArray {
            if let exercise = transform(json: jsonObject) {
                exercisesArray.append(exercise)
            }
        }
        return exercisesArray
    }
}
