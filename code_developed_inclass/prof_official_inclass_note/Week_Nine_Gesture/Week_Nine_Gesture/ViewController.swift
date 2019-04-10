//
//  ViewController.swift
//  Week_Nine_Gesture
//
//  Created by Alireza Moghaddam on 2019-03-18.
//  Copyright © 2019 Alireza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func mySwipeHandler(_ sender: Any) {
        
        print("Image Swiped")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pr = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.labelPinched(recognizer:)))
        
        let tr = UITapGestureRecognizer(target: self, action: #selector(ViewController.labelTapped(recognizer:)))
        tr.numberOfTapsRequired = 2
        
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tr)
        label.addGestureRecognizer(pr)
    
        
    }
    
    
    
    
    
    @objc func labelTapped(recognizer: UITapGestureRecognizer)
    {
        print("Label Tapped")
        
    }

    @objc func labelPinched(recognizer: UIPinchGestureRecognizer)
    {
        print("Label Pinched")
        
    }


}

