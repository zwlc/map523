//
//  ViewController.swift
//  Lab1New2
//
//  Created by Youngmin Ko on 2019-01-16.
//  Copyright © 2019 Youngmin Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var t1: UITextField!
    @IBOutlet weak var btnSet: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var btnreset: UIButton!
    @IBOutlet weak var set: UIButton!
    @IBOutlet weak var info: UILabel!
    
    var timer = Timer()
    var seconds = 60
    var minutes = 0
    var hsec = 0;
    var ifStop = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("minutes: " , minutes)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func start(_ sender: Any) {
        if(ifStop == false)
        {
            let result = Int(t1.text!)
            seconds = result!*60
            print(seconds)
            runTimer()
        }
        else
        {
            seconds = hsec
            print(seconds)
            runTimer()
        }
    }
    @IBAction func set(_ sender: Any) {
       if let r1 = Int(t1.text!)
       {
            if(r1 > 60 || r1 < 1)
            {
                info.text = "The number must be between 1 and 60"
                t1.text = ""
                timer.invalidate()
            }
            else
            {
                info.text = "Number Set Press Start"
            }
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        timer.invalidate()
        ifStop = false
        hsec = 0
        seconds = 60
        minutes = 0
        t1.text = ""
        display.text = "MM:SS"
        info.text = "Enter Minutes:"
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @IBAction func stop(_ sender: Any) {
        hsec = seconds
        seconds = 0
        ifStop = true
    }
    
    @objc func updateimer(){
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        }
        else
        {
            seconds -= 1
            display.text = timeString(time: TimeInterval(seconds))
            //display.text = String(seconds)
            //labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String
    {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

