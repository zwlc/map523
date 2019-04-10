
//  ViewController.swift
//  tempMaps
//
//  Created by Mason Ko on 2019-03-11.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let latitude: CLLocationDegrees = 43.77
        let longitude: CLLocationDegrees = -79.50
        
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span: MKCoordinateSpan =
            MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location: CLLocationCoordinate2D =
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region:MKCoordinateRegion =
            MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated:true)
        
        //Adding annotation to map
        
        let annotation = MKPointAnnotation()
        annotation.title = "Seneca College"
        annotation.subtitle = "I will visit Seneca"
        annotation.coordinate = location
        map.addAnnotation(annotation)
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
    }
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer){
        let touchpoint = gestureRecognizer.location(in: self.map)
        let coordinate = map.convert(touchpoint, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Custom Place"
        annotation.subtitle = "To be visited next week"
        map.addAnnotation(annotation)
    }
}

