//
//  ViewController.swift
//  lab1.1
//
//  Created by Mason Ko on 2019-01-30.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer : Timer!
    
    var cntSec = 0
    var cntMS = 0
    
    @IBOutlet weak var lbTime: UILabel!
    @IBAction func startAction(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(){
        if cntMS == 99{
            cntMS = 0
            cntSec += 1
        }else{
            cntMS += 1
        }
        lbTime.text = String(format: "%02d:%02d", cntSec, cntMS)
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

