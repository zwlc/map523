//
//  ViewController.swift
//  DataDemo
//
//  Created by Alireza Moghaddam on 2019-03-03.
//  Copyright © 2019 Alireza. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
        //To Insert data:
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        /*
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        let newUser2 = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("Marry", forKey: "username")
        newUser.setValue("1234", forKey: "password")
        newUser.setValue(55, forKey: "age")
        
        newUser2.setValue("Johnston", forKey: "username")
        newUser2.setValue("1234", forKey: "password")
        newUser2.setValue(45, forKey: "age")
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Error!!!")
        }
        
  */
        //To iterate through a table
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
    /*
        
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
        
 */
        
        //Advance search operations
        //request.predicate = NSPredicate(format: "username = %@", "John")
        
        //https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html
        request.predicate = NSPredicate(format: "age > %@", "40")
        
        
        //To update a value in the database
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for item in results as! [NSManagedObject] {
                    
                    if let username = item.value(forKey: "username") as? String {
                    
                        //item.setValue("Mature", forKey: "username")
                        context.delete(item)
                        
                        do {
                            try context.save()      //Make sure that you call context.save() everytime
                            print("\(username) has been updated")
                        }
                        catch {
                            
                        }
                        
                    }
                }
            }
            
        }
        
        catch {
            
            print("Error")
        }
        
        
 
 
    }
 


}

