//
//  ViewController.swift
//  lab1
//
//  Created by Mason Ko on 2019-01-29.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Creating an instance of timer class
    var stopWatchTimer = Timer();
    var currentTime = 0;
    
    // IBOutlets
    @IBOutlet weak var labelMinutes: UILabel!
    @IBOutlet weak var labelSeconds: UILabel!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    
    
    // IBActions
    @IBAction func hasButtonStartPressed(_ sender: Any) {
        // when start button gets triggered we need to hide the start button and showing the pause button and enabling the stop button
        buttonStart.isHidden = true;
        buttonPause.isHidden = false;
        buttonStop.isEnabled = true;
        
        // now we need to create a timer using a instance method of the timer class
        stopWatchTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTime)), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func hasButtonPasuePressed(_ sender: Any) {
        // when pause button gets triggered we need to hide the pause button and showing the start button
        buttonStart.isHidden = false;
        buttonPause.isHidden = true;
        
        // wen eed to pause the timer or stop watch timer when the pause button gets triggered...
        stopWatchTimer.invalidate(); // pause the timer
    }
    
    @IBAction func hasButtonStopPressed(_ sender: Any) {
        buttonPause.isHidden = true;
        buttonStart.isHidden = false;
        buttonStop.isEnabled = false;
        
        currentTime = 0;
        labelMinutes.text = "0";
        labelSeconds.text = "0";
        
        // stopping the timer
        stopWatchTimer.invalidate();
        
    }
    
    @objc func updateTime(){
        currentTime += 1;
        labelMinutes.text = "\(currentTime % 60)";
        labelSeconds.text = "\(currentTime / 60)";
        
        if currentTime == 3600 {
            // 3600 secs which is equals to one hours...
            // when it hits 3600 we will reset hte current time counter to zero
            currentTime = 0;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // when view gets loaded we need to hide the pause button and also we need to disable the stop button
        buttonPause.isHidden = true;
        buttonStop.isEnabled = false;
        
    }
    
    
}
