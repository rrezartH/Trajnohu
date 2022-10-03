//
//  RunningViewController.swift
//  Trajnohu
//
//  Created by user226415 on 9/30/22.
//

import UIKit
import MapKit

class RunningViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var pathPickerViewButton: UIButton!
    @IBOutlet weak var cityPickerViewButton: UIButton!
    @IBOutlet weak var runningPathsMKMV: MKMapView!
    @IBOutlet weak var titleLbl: UILabel!

    var citiesPickerView = UIPickerView()
    var pathsPickerView = UIPickerView()
    var runningPathsArray: [MKPointAnnotation] = []
    let locationManager = CLLocationManager()
    let userLocation = MKPointAnnotation()
    var cities: [City] = []

    let screenWidth = UIScreen.main.bounds.width - 16
    let screenHeight = UIScreen.main.bounds.height / 3

    let selectedRow = 0
    var selectedCity: City = City(name: "", region: Region(latitude: 0.0, longitude: 0.0, latitudinalMeters: 0, longitudinalMeters: 0), runningPaths: [])
    var selectedPath: RunningPath = RunningPath(name: "", runningPathPoints: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerViews()
        setupLocationManager()
        runningPathsMKMV.addAnnotation(userLocation)
        createCities()
    }

    @IBAction func pathPopUpPicker(_ sender: Any) {
        showPathsPickerView()
    }

    @IBAction func cityPopUpPicker(_ sender: Any) {
       showCitiesPickerView()
    }

    func setupPickerViews() {
        pathPickerViewButton.isEnabled = false
        pathsPickerView.dataSource = self
        pathsPickerView.delegate = self

        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
    }

    func showPathsPickerView() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        pathsPickerView.frame = CGRect(x: 0, y: 0, width: screenWidth - 16 , height: screenHeight)

        pathsPickerView.selectRow(selectedRow, inComponent: 0, animated: false)

        vc.view.addSubview(pathsPickerView)
        pathsPickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pathsPickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true

        let alert = UIAlertController(title: "Zgjedhni shtegun", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = cityPickerViewButton
        alert.popoverPresentationController?.sourceRect = cityPickerViewButton.bounds

        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))

        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedPath = self.selectedCity.runningPaths[self.pathsPickerView.selectedRow(inComponent: 0)]
            if(self.runningPathsMKMV.annotations.count > 0) {
                self.runningPathsMKMV.removeAnnotations(self.runningPathsMKMV.annotations)
            }
            self.showPathInMap(runningPath: self.selectedPath)
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func showCitiesPickerView() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        citiesPickerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        citiesPickerView.selectRow(selectedRow, inComponent: 0, animated: false)

        vc.view.addSubview(citiesPickerView)
        citiesPickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        citiesPickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true

        let alert = UIAlertController(title: "Zgjedhni qytetin", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = cityPickerViewButton
        alert.popoverPresentationController?.sourceRect = cityPickerViewButton.bounds

        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))

        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedCity = self.cities[self.citiesPickerView.selectedRow(inComponent: 0)]
            self.pathPickerViewButton.isEnabled = true
            self.pathsPickerView.reloadAllComponents()
            self.runningPathsMKMV.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.selectedCity.region.latitude, longitude: self.selectedCity.region.longitude), latitudinalMeters: self.selectedCity.region.latitudinalMeters, longitudinalMeters: self.selectedCity.region.longitudinalMeters)
            self.runningPathsMKMV.reloadInputViews()
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            runningPathsMKMV.delegate = self
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation.title = "Lokacioni yt!"
        userLocation.coordinate = CLLocationCoordinate2D(latitude: manager.location?.coordinate.latitude ?? 0.0, longitude: manager.location?.coordinate.longitude ?? 0.0)

        runningPathsMKMV.region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == self.citiesPickerView {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth - 32, height: 30))
            label.text = cities[row].name
            return label
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth - 32, height: 30))
        label.text = selectedCity.runningPaths[row].name
        return label
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.citiesPickerView {
            return cities.count
        }
        return selectedCity.runningPaths.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }

    func createCities() {
        let startingPoint = RunningPathPoint(title: "Fillimi", latitude: 42.46342232011041, longitude: 21.469477292671378)
        let midPoint = RunningPathPoint(title: "Ketu ben nje kthese.", latitude: 42.472935130640835, longitude: 21.483789559546636)
        let endPoint = RunningPathPoint(title: "Mbarimi", latitude: 42.474866007162206, longitude: 21.47343623305296)
        let albanicaPath = RunningPath(name: "Vrapi i Albanikes", runningPathPoints: [startingPoint, midPoint, endPoint])

        let startingPoint1 = RunningPathPoint(title: "Fillimi", latitude: 42.459596350555124, longitude: 21.46643670813648)
        let midPoint1 = RunningPathPoint(title: "Ketu ben nje kthese.", latitude: 42.4518130951265, longitude:  21.469386256016808)
        let endPoint1 = RunningPathPoint(title: "Mbarimi", latitude: 42.45461077209717, longitude: 21.463314910032995)
        let kamnikPath = RunningPath(name: "Vrapi i Kamnikut", runningPathPoints: [startingPoint1, midPoint1, endPoint1])

        let startingPoint2 = RunningPathPoint(title: "Fillimi", latitude: 42.47064504514381, longitude: 21.462818368658493)
        let midPoint2 = RunningPathPoint(title: "Ketu ben nje kthese.", latitude: 42.466233115841575, longitude: 21.4621412668559)
        let endPoint2 = RunningPathPoint(title: "Mbarimi", latitude: 42.47515654567137, longitude: 21.455370248990846)
        let gavranPath = RunningPath(name: "Vrapi i Gavranit", runningPathPoints: [startingPoint2, midPoint2, endPoint2])

        let startingPoint3 = RunningPathPoint(title: "Fillimi", latitude: 42.46750232844958, longitude: 21.468099674746895)
        let midPoint3 = RunningPathPoint(title: "Ketu ben nje kthese.", latitude: 42.47227884735679, longitude: 21.471349629878002)
        let endPoint3 = RunningPathPoint(title: "Mbarimi", latitude: 42.47222477559805, longitude: 21.464483183330383)
        let dheuBardhePath = RunningPath(name: "Vrapi i Dheut te Bardhe", runningPathPoints: [startingPoint3, midPoint3, endPoint3])

        let startingPoint4 = RunningPathPoint(title: "Fillimi", latitude: 42.6701367722143, longitude: 21.192454895321017)
        let midPoint4 = RunningPathPoint(title: "Ketu ben nje kthese.", latitude: 42.67248711271039, longitude: 21.19677132316097)
        let endPoint4 = RunningPathPoint(title: "Mbarimi", latitude: 42.667648497438755, longitude: 21.199591641795507)
        let germiaPath = RunningPath(name: "Vrapi i Germise", runningPathPoints: [startingPoint4, midPoint4, endPoint4])

        let placeholderCity = City(name: "Zgjedh Qytetin", region: Region(latitude: 0.0, longitude: 0.0, latitudinalMeters: 0, longitudinalMeters: 0), runningPaths: [])
        let city1 = City(name: "Gjilan", region: Region(latitude: 42.4635, longitude: 21.4694, latitudinalMeters: 5000, longitudinalMeters: 5000), runningPaths: [albanicaPath, kamnikPath, gavranPath, dheuBardhePath])
        let city2 = City(name: "Prishtina", region: Region(latitude: 42.6629, longitude: 21.1655, latitudinalMeters: 7000, longitudinalMeters: 7000), runningPaths: [germiaPath])
        cities.append(placeholderCity)
        cities.append(city1)
        cities.append(city2)
    }

    func showPathInMap(runningPath: RunningPath) {
        var count: Int = 0
        var pointsToDrawBetween: [MKPointAnnotation] = []

        if runningPathsMKMV.overlays.count > 0 {
            runningPathsMKMV.removeOverlays(runningPathsMKMV.overlays)
        }

        for runningPathPoint in runningPath.runningPathPoints {
            let pathPoint = MKPointAnnotation()
            pathPoint.title = runningPathPoint.title
            pathPoint.coordinate = CLLocationCoordinate2D(latitude: runningPathPoint.latitude, longitude: runningPathPoint.longitude)
                runningPathsMKMV.addAnnotation(pathPoint)
            count += 1
            pointsToDrawBetween.append(pathPoint)

            if count == 2 {
                drawPathBetween(start: pointsToDrawBetween[0], end: pointsToDrawBetween[1])
                pointsToDrawBetween.removeFirst()
                count = 1
            }
        }
    }

    func drawPathBetween(start: MKPointAnnotation, end: MKPointAnnotation) {
        let startPlacemark = MKPlacemark(coordinate: start.coordinate)
        let endPlacemark = MKPlacemark(coordinate: end.coordinate)

        let startMapItem = MKMapItem(placemark: startPlacemark)
        let endMapItem = MKMapItem(placemark: endPlacemark)

        let directionRequest = MKDirections.Request()
        directionRequest.source = startMapItem
        directionRequest.destination = endMapItem
        directionRequest.transportType = .walking

        let direction = MKDirections(request: directionRequest)

        direction.calculate { response, error in
            if let response = response {
                let routes = response.routes
                if routes.count > 0 {
                    self.runningPathsMKMV.addOverlay(routes[0].polyline, level: .aboveRoads)
                }
            }
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 4
        renderer.strokeColor = .green
        return renderer
    }

}
