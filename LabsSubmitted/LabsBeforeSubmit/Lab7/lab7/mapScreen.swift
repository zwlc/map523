//
//  ViewController.swift
//  lab7
//
//  Created by Mason Ko on 2019-04-02.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapScreen: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lbl_latitude: UILabel!
    @IBOutlet weak var lbl_longitude: UILabel!
    @IBOutlet weak var lbl_altitude: UILabel!
    @IBOutlet weak var lbl_course: UILabel!
    @IBOutlet weak var lbl_speed: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
//        lbl_latitude.text = String(locationManager.location!.coordinate.latitude)
//        lbl_longitude.text = String(locationManager.location!.coordinate.longitude)
//        lbl_altitude.text = String(locationManager.location!.altitude)
//        lbl_course.text = String(locationManager.location!.course)
//        lbl_speed.text = String(locationManager.location!.speed)
        
        
        
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
            
        } else {
            print("debug: enable location!!")
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            
            
        case .denied:
            // show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            // if it's not determined, we ask user permission!
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // show alert instructing them how to turn on permissions
            break
        case .authorizedAlways:
            break
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
}


extension mapScreen: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension mapScreen: MKMapViewDelegate {
    func mapView(_ mapView:MKMapView, regionDidChangeAnimated animated: Bool){
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
//            if let _ = error{
//                // to do
//                return
//            }
            
            guard let placemark = placemarks?.first else {
                // to do
                return
            }
            let streetNo = String(placemark.subThoroughfare ?? " ")
            let streetName = String(placemark.thoroughfare ?? " ")
            
            self.lbl_altitude.text = String(self.locationManager.location!.altitude)
            self.lbl_latitude.text = String(self.locationManager.location!.coordinate.latitude)
            self.lbl_longitude.text = String(self.locationManager.location!.coordinate.longitude)
            self.lbl_altitude.text = String(self.locationManager.location!.altitude)
            self.lbl_course.text = String(self.locationManager.location!.course)
            self.lbl_speed.text = String(self.locationManager.location!.speed)
            self.lbl_address.text = streetNo + " " + streetName
        }
    }
}
