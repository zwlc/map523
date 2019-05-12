//
//  ViewController.swift
//  lab3-tictactoe
//
//  Created by Mason Ko on 2019-04-08.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myCamera: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func camClicked(_ sender: UIBarButtonItem) {
        print("Camera clicked!")
    }
    
}

