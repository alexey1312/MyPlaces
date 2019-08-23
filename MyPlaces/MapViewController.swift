//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Admin on 23/08/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var place = Place()
    let locationManager = CLLocationManager()
    let regionInMeters = 5_000.00
    var incomeSegueIndetifier = ""
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapPinImage: UIImageView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationSevices()
        setupMapView()
         
    }
    
    @IBAction func centreViewInUserLocation() {
        
        showUserLocation()
    }
    
    @IBAction func doneButtonPressed() {
    }
    
    @IBAction func closeVC() {
        dismiss(animated: true)
    }
    
    private func setupMapView() {
        if incomeSegueIndetifier == "showPlace" {
            setupPlacemark()
            mapPinImage.isHidden = true
            adressLabel.isHidden = true
            doneButton.isHidden = true
        }
    }
    
    private func setupPlacemark() {
        
        guard let location = place.location else { return }
        
        //Преобразование в геокоординаты
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    private func checkLocationSevices() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAutorization()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(
                    title: "Location Srvices are Disabled",
                    message: "To enable it go: Settings -> Privacy -> Location Services and turn On"
                )
        }
    }
}
    //Определяем точность геопозиции
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //Обработка статуса включенной геолокации
    private func checkLocationAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            if incomeSegueIndetifier == "getAdress" {
                showUserLocation()
            }
            break
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(
                                title: "You location is not Avaible",
                                message: "To give permission Go to: Setting -> MyPlaces -> Location"
                        )
            }
            break
        //Show aAllertController
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
        //Show aAllertController
            break
        case .authorizedAlways:
        //Show aAllertController
            break
        @unknown default:
            print("New case is availebe")
        }
    }

private func showUserLocation() {
    
    if let location = locationManager.location?.coordinate {
        let region = MKCoordinateRegion(center: location,
                                        latitudinalMeters: regionInMeters,
                                        longitudinalMeters: regionInMeters)
        
        mapView.setRegion(region, animated: true)
    }
}
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
    }
    
}
