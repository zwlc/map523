//
//  ViewController.swift
//  Lab7
//
//  Created by Fenil Shah on 2019-03-13.
//  Copyright © 2019 Fenil Shah. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate  {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var lonField: UITextField!
    @IBOutlet weak var altField: UITextField!
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var speedField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(locations)
        
        let userLocation: CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let altitude = userLocation.altitude
        let course = userLocation.course
        let speed = userLocation.speed
       // let address = getAddressFromLatLon(pdblLatitude: String.latitude, withLongitude: String.longitude)
        
        let longDelta = 0.05
        let latDelta = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        map.addAnnotation(annotation)
        
        latField.text! = String(latitude)
        lonField.text! = String(longitude)
        courseField.text! = String(course)
        altField.text! = String(altitude)
        speedField.text! = String(speed)
       // addressField.text! = String(address)
        
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country!)
                    print(pm.locality!)
                    print(pm.subLocality!)
                    print(pm.thoroughfare!)
                    print(pm.postalCode!)
                    print(pm.subThoroughfare!)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
                    print(addressString)
                }
        })
        
    }

    
}

