//
//  ViewController.swift
//  first
//
//  Created by Alireza Moghaddam on 2019-01-28.
//  Copyright © 2019 Alireza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btn: UIButton!
    
    var counter = 0
    
    var timer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        img.image = UIImage(named: "./images/frame_00_delay-0.04s.gif")
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
    }

    @IBAction func btnPressed(_ sender: Any) {
        
        counter += 1
        if counter == 10{
            counter = 0
        }
        img.image = UIImage(named: "./images/frame_0\(counter)_delay-0.04s.gif")
        
    }
    
    @IBAction func fadeIn(_ sender: Any) {
        img.alpha = 0
        
        UIView.animate(withDuration: 1, animations: self.img.alpha = 1)
    }
    
    @objc func animate()
    {
        counter += 1
        if counter == 10{
            counter = 0
        }
        img.image = UIImage(named: "./images/frame_0\(counter)_delay-0.04s.gif")
    }
 
    
}

