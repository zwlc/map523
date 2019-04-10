//
//  ViewController.swift
//  GuessMyPick
//
//  Created by Alireza Moghaddam on 2019-01-14.
//  Copyright © 2019 Alireza. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    
    @IBOutlet weak var tbxNumber: UITextField!
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var lblAnswer: UILabel!
    
    //Defining and initializing an integer to store the random number generated by the computer
    var randomNumber:Int = 2


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randomNumber =  Int.random(in: 0..<100)
    }
    
    //The function to handle the click events
    @IBAction func buttonPress(_ sender: UIButton) {
        
        if let userInputNum = Int(tbxNumber.text!){
            if(userInputNum<randomNumber) {
                lblAnswer.text = "You guessed less than what I picked";
            } else if(userInputNum>randomNumber) {
                lblAnswer.text = "You guessed more than what I picked"
            } else {
                lblAnswer.text = "Congratulations!!!"
            }
            
            
        }
    }
    

}
