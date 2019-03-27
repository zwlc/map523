//
//  ViewController.swift
//  lab1_timer
//
//  Created by Mason Ko on 2019-03-27.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblDisplayTime: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var TF1: UITextField!
    @IBOutlet weak var btnSet: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    var timer = Timer()
    var seconds: Int = 60
    var minutes: Int = 0
    var hsec: Int = 0
    var ifStop: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func start(_ sender: Any) {
        if(ifStop == false)
        {
            let result = Int(TF1.text!)
            seconds = result! * 60
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
        if let r1 = Int(TF1.text!)
        {
            if(r1 > 60) || (r1 < 1)
            {
                lblInfo.text = "The number must be between 1 ~ 60"
                TF1.text = ""
                timer.invalidate()
            }
            else
            {
                lblInfo.text = "Number Set! Press Start"
            }
        }
        
    }
    @IBAction func stop(_ sender: Any) {
        ifStop = true
        hsec = seconds
        seconds = 0
    }
    @IBAction func reset(_ sender: Any) {
        timer.invalidate()
        ifStop = false
        seconds = 60
        minutes = 0
        hsec = 0
        TF1.text = ""
        lblDisplayTime.text = "MM:SS"
        lblInfo.text = "Enter Minutes"
    }
    
    @objc func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer()
    {
        if (seconds < 1)
        {
            timer.invalidate()
            // send alert to indicate time's up
        }
        else
        {
            seconds -= 1
            lblDisplayTime.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    @objc func timeString(time: TimeInterval) ->String
    {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}

