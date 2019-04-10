//
//  InterfaceController.swift
//  Week_Nine_Apple_Watch WatchKit Extension
//
//  Created by Alireza Moghaddam on 2019-03-25.
//  Copyright © 2019 Alireza. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var clickButton: WKInterfaceButton!
    
    var timer : Timer?
    
    var heartRate = 80
    
    @IBAction func storeHandler() {
        
        print("Store")
        
        //How to write a value for a variable
        UserDefaults.standard.set(12, forKey: ("heartRate"))
        UserDefaults.standard.synchronize()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.updateValue()
        }
        
    }
    
    func updateValue()
    {
        
        UserDefaults.standard.value(forKey: "heartRate")
        lbl.setText("\(heartRate)")
        
        heartRate += 1
        
        UserDefaults.standard.set(12, forKey: ("heartRate"))
        UserDefaults.standard.synchronize()
        
    }
    
    
    @IBAction func trashHandler() {
        
    
    }
    
    
    @IBAction func retreiveHndler() {
        
        print("Retreive")
        
        //To retreive the value
        var heartRate = UserDefaults.standard.value(forKey: "heartRate")
        
        var heartRateValues = UserDefaults.standard.array(forKey: "heartRate") as? [Int8]
        
        //print(heartRate ?? 0)
        
        lbl.setText("Hr is: \(heartRate!)")
    }
    @IBOutlet weak var lbl: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    
    func record()
    {
        
    }
    
    @IBAction func clickHandler() {
        
        lbl.setText("Button Clicked!!")
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
