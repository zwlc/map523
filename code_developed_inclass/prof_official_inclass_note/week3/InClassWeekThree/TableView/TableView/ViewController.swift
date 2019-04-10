//
//  ViewController.swift
//  TableView
//
//  Created by Alireza Moghaddam on 2019-01-21.
//  Copyright © 2019 Alireza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellContents = ["Alex", "John", "William"]
  
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return cellContents.count
        
    }
    
   
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "FirstCell")
        cell.textLabel?.text = cellContents[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

