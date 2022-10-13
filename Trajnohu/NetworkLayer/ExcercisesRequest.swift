//
//  ExcercisesRequest.swift
//  Trajnohu
//
//  Created by TDI Student on 13.10.22.
//

import Foundation
import Alamofire
import SwiftyJSON

class ExcercisesRequest: NSObject {
    static func getExercises(completionHandler: @escaping(_ exercises: [Exercise]?, _ error: Error?) -> Void) {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "c40d9e536dmsh2a5bf8232065000p1aff1bjsn086c282be771",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        let urlString = "https://exercisedb.p.rapidapi.com/exercises"
        
        AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data)
                if let exercisesArray = Exercise.transform(jsonArray: jsonData.array ?? []) {
                    completionHandler(exercisesArray, nil)
                }
                break;
            case .failure(let error):
                completionHandler(nil, error)
                print(error)
                break
            }
        }
    }
    
}
