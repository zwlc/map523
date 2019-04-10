//
//  InterfaceController.swift
//  week9(mar25)_inclass_watch WatchKit Extension
//
//  Created by Mason Ko on 2019-03-25.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var clickButton: WKInterfaceButton!
    @IBOutlet weak var lbl: WKInterfaceLabel!

    @IBAction func storeHandler() {
        print("Store")
        // how to write a value for a variable
        UserDefaults.standard.set(12, forKey: ("heartRate"))
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func retrieveHandler() {
        print("Retrive")
        // to retrieve the value
        var heartRate = UserDefaults.standard.value(forKey: "heartRate")
        var heartRateValues = UserDefaults.standard.array(forKey: "heartRate") as? [Int8]
        lbl.setText("Hr is : \(heartRate!)")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
    }
    
    @IBAction func clickHandler() {
        lbl.setText("Button Clicked!")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
