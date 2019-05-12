//
//  ViewController.swift
//  Lab6
//
//  Created by Mason Ko on 2019-03-21.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // signin page
    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var lbl_msg: UILabel!
    // signup page
    @IBOutlet weak var tf_signUpUsername: UITextField!
    @IBOutlet weak var tf_signUpPassword: UITextField!
    @IBOutlet weak var tf_signUpAddress: UITextField!
    @IBOutlet weak var tf_signUpAge: UITextField!
    @IBOutlet weak var lbl_signUp: UIButton!
    @IBOutlet weak var lbl_signUpMsg: UILabel!
    
    var usernameInput = ""
    var passwordInput = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printUsers()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgi")!)
        // ddd
    }
    
    @IBAction func signin(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        request.returnsObjectsAsFaults = false
        
        do {
            usernameInput = tf_username.text!
            passwordInput = tf_password.text!
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if(data.value(forKey: "username") as! String == usernameInput)
                {
                    if(data.value(forKey: "password") as! String == passwordInput)
                    {
                        lbl_msg.text = "Hello \(usernameInput)!"
                        tf_username.text = ""
                        tf_password.text = ""
                    }
                    else
                    {
                        lbl_msg.text = "Incorrect Password"
                        tf_password.text = ""
                    }
                }
                else
                {
                    lbl_msg.text = "Username is not found, Please SignUp to login"
                    tf_username.text = ""
                    tf_password.text = ""
                }
            }
            
        } catch {
            
            print("Error")
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context)
        
        newUser.setValue(tf_signUpUsername.text!, forKey: "username")
        newUser.setValue(tf_signUpPassword.text!, forKey: "password")
        newUser.setValue(tf_signUpAddress.text!, forKey: "address")
        newUser.setValue(Int(tf_signUpAge.text!), forKey: "age")
        
        do{
            try context.save()
            tf_signUpUsername.text = ""
            tf_signUpPassword.text = ""
            tf_signUpAge.text = ""
            tf_signUpAddress.text = ""
            lbl_signUpMsg.text = "User Saved"
        }
        catch {
            print("Error!!!")
        }
        
        printUsers()
    }
    
    
    func printUsers()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.value(forKey: "username") as? String {
                        
                        print(username)
                    }
                }
                
            }
            else {
                print("No Result!!")
            }
            
        }
            
        catch {
            print("Error when fetching Data!!")
        }
    }
    
    
    
}

