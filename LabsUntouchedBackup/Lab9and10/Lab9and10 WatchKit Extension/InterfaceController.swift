//
//  InterfaceController.swift
//  Lab9and10 WatchKit Extension
//
//  Created by Fenil Shah on 2019-03-27.
//  Copyright © 2019 Fenil Shah. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var recordBtn: WKInterfaceButton!
    @IBOutlet weak var display: WKInterfaceLabel!
    @IBOutlet weak var stopBtn: WKInterfaceButton!
    
    @IBOutlet weak var show: WKInterfaceButton!
    @IBOutlet weak var first: WKInterfaceLabel!
    @IBOutlet weak var Second: WKInterfaceLabel!
    @IBOutlet weak var Third: WKInterfaceLabel!
    @IBOutlet weak var Fourth: WKInterfaceLabel!
    @IBOutlet weak var Fifth: WKInterfaceLabel!
    
    
    var timer : Timer?
    var heartRate = Int.random(in: 80 ... 110)
    var session = [Int]()
    var savedHeartRate = [Int]()
    
    @IBAction func delete() {
        deleteValues()
    }
    
    @IBAction func history() {
    presentController(withName:"historyView", context: nil)

    }
    @IBAction func showHandler() {
        printValues()
        findValues()
    }
    
    @IBAction func recordStart() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.updateValue()
        }
    }
    
    func updateValue()
    {
        display.setText("\(heartRate)")
        heartRate = Int.random(in: 80 ... 110)
        savedHeartRate.append(heartRate)
    }
    
    @IBAction func stopAction() {
        display.setText("Session Complete")
        timer?.invalidate()
        if(session.isEmpty)
        {
            session.append(0)
        }
        else
        {
            session.append(session.last!+1)
        }
        
        UserDefaults.standard.set(savedHeartRate, forKey: "heartRate\(session[session.last!])")
        savedHeartRate = []
        //printValues()
    }
    
    func printValues()
    {
        for foo in 0..<5
        {
            print(UserDefaults.standard.array(forKey: "heartRate\(foo)") as? [Int] ?? [])
        }
    }
    
    func findValues()
    {
        for foo in 0..<5
        {
            let s = UserDefaults.standard.array(forKey: "heartRate\(foo)") as? [Int] ?? []
               if(s.count != 0)
               {
                let max = s.max()
                let min = s.min()
                let avg = (s.reduce(0, +) / s.count)
                //let combie = [max, min, avg]
                //print(combie)
                
                        if(foo == 0)
                        {
                            first.setText("1: Min:\(min ??  0), Max:\(max ?? 0), Avg:\(avg)")
                        }
                        if(foo == 1)
                        {
                            Second.setText("2: Min:\(min ??  0), Max:\(max ?? 0), Avg:\(avg)")                       }
                        if(foo == 2)
                        {
                            Third.setText("3: Min:\(min ??  0), Max:\(max ?? 0), Avg:\(avg)")                  }
                        if(foo == 3)
                        {
                            Fourth.setText("4: Min:\(min ??  0), Max:\(max ?? 0), Avg:\(avg)")                      }
                        if(foo == 4)
                        {
                            Fifth.setText("5: Min:\(min ??  0), Max:\(max ?? 0), Avg:\(avg)")                     }
                }
        }
    }
    
    func deleteValues()
    {
        for foo in 0..<6
        {
            let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: "heartRate\(foo)")
            }
        }
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        printValues()
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

}
