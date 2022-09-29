//
//  RunningViewController.swift
//  Trajnohu
//
//  Created by user226415 on 9/30/22.
//

import UIKit
import MapKit

class RunningViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var runningPathsMKMV: MKMapView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var runningPathsArray: [MKPointAnnotation] = []
    
    let locationManager = CLLocationManager()
    let userLocation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        runningPathsMKMV.addAnnotation(userLocation)
        createCityWithPaths()
    }
    
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation.title = "Lokacioni yt!"
        userLocation.coordinate = CLLocationCoordinate2D(latitude: manager.location?.coordinate.latitude ?? 0.0, longitude: manager.location?.coordinate.longitude ?? 0.0)
        
        runningPathsMKMV.region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
    
    func createCityWithPaths() {
        let startingPoint = RunningPathPoint(title: "Fillimi", latitude: 42.46342232011041, longitude: 21.469477292671378)
        let midPoint = RunningPathPoint(title: "Ketu ben nje kthese.", latitude: 42.472935130640835, longitude: 21.483789559546636)
        let endPoint = RunningPathPoint(title: "Mbarimi", latitude: 42.474866007162206, longitude: 21.47343623305296)
        let albanicaPath = RunningPath(name: "Vrapi i Albanikes", runningPathPoints: [startingPoint, midPoint, endPoint])
        let city1 = City(name: "Gjilan", runningPaths: [albanicaPath])
        
        for paths in city1.runningPaths {
            for runningPathPoint in paths.runningPathPoints {
                let pathPoint = MKPointAnnotation()
                pathPoint.title = runningPathPoint.title
                pathPoint.coordinate = CLLocationCoordinate2D(latitude: runningPathPoint.latitude, longitude: runningPathPoint.longitude)
                runningPathsMKMV.addAnnotation(pathPoint)
            }
        }
    }

}
