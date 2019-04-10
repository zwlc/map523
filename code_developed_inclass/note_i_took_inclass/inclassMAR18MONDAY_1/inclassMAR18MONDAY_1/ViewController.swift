//
//  ViewController.swift
//  inclassMAR18MONDAY_1
//
//  Created by Mason Ko on 2019-03-18.
//  Copyright © 2019 Mason Ko. All rights reserved.
//


// week 9 gesture!!!
/*
 gesture control is simple.
 take action whenever gesture happens
 
 there is gesture class 'GestureRecognition'
 many subclass 
 */
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func mySwipeHandler(_ sender: Any) {
        print("Image swiped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pr = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.labelPinched(recognizer:))) // pr = pinch recognizer
        
        let tr = UITapGestureRecognizer(target: self, action: #selector(ViewController.labelTapped(recognizer:)))// tr = tap recognizer
        
        tr.numberOfTapsRequired = 2
        
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tr)
        label.addGestureRecognizer(pr)
    }
    
    @objc func labelTapped(recognizer: UITapGestureRecognizer){
        print("Label Tapped")
    }
    @objc func labelPinched(recognizer: UIPinchGestureRecognizer){
        print("Label Pinched")
    }

}
