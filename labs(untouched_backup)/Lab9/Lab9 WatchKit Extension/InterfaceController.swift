//
//  InterfaceController.swift
//  Lab9 WatchKit Extension
//
//  Created by Anh Tran on 2019-04-02.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var timer : Timer?
    var hrData = [[Int]]()
    var heartRate = 0

    var hrMin = 0
    var hrMax = 0
    var hrCycle = 0
    var hrTotal = 0
    var hrAverage = 0

    @IBOutlet weak var hrLabel: WKInterfaceLabel!
    @IBOutlet weak var recordButton: WKInterfaceButton!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        hrLabel.setText(" ")
        hrData = UserDefaults.standard.array(forKey: "hrData") as? [[Int]] ?? [[Int]]()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func recordClick() {
        if timer?.isValid == true {
            timer?.invalidate()
            recordButton.setTitle("Record")
            hrAverage = hrTotal / hrCycle
            hrData.append([hrMin, hrMax, hrAverage])

            UserDefaults.standard.set(hrData, forKey: ("hrData"))
            UserDefaults.standard.synchronize()

            hrMin = 0
            hrMax = 0
            hrCycle = 0
            hrTotal = 0
            hrAverage = 0
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.updateHr()
            }
            recordButton.setEnabled(false)
            recordButton.setTitle("Starting...")
        }
    }

    func updateHr() {
        heartRate = Int.random(in: 80 ... 110)
        hrLabel.setText(String(heartRate))

        hrCycle += 1
        hrTotal += heartRate

        if heartRate < hrMin || hrMin == 0 {
            hrMin = heartRate
            recordButton.setEnabled(true)
            recordButton.setTitle("Stop")
        }
        if heartRate > hrMax {
            hrMax = heartRate
        }
    }
    
    @IBAction func clearAllClick() {
        hrData = [[Int]]()
        UserDefaults.standard.set(hrData, forKey: ("hrData"))
        UserDefaults.standard.synchronize()
    }

    @IBAction func historyClick() {
        presentController(withName: "dataTable", context: hrData)
    }
}
