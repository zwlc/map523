//
//  ViewController.swift
//  lab2_FoodTracker
//
//  Created by Mason Ko on 2019-03-27.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    
    
    // MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
//        if(nameTextField.text != ""){
//            mealNameLabel.text = nameTextField.text
//        }
//        else
//        {
//            mealNameLabel.text = "Meal Name"
//        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }

}

