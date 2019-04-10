//
//  ViewController.swift
//  NavigationBar
//
//  Created by Alireza Moghaddam on 2019-01-21.
//  Copyright © 2019 Alireza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myCamera: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func camClicked(_ sender: Any) {
        print("Camera is pressed")
    }
}

