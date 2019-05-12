//
//  ViewController.swift
//  TicTacToe
//
//  Created by Alireza Moghaddam on 2019-01-28.
//  Copyright © 2019 Alireza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblGameStatus: UILabel!
    
    
    
    var gameOver = false
    
    var turn = 1    //1 is O  2 is X
    
    var board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winning_conditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bgi1.jpg")!)
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"\(randomImage())")!)
    }
    
    
    @IBAction func btnPressed(_ sender: AnyObject) {
        print(sender.tag)
        if board[sender.tag - 1] == 0 && gameOver != true
        {
            
            print("bgi change")
            if turn == 1
            {
                
                sender.setImage(UIImage(named: "nought.png"), for: [])
                board[sender.tag - 1] = 1
                
                turn = 2
            }
            else{
                
                sender.setImage(UIImage(named: "cross.png"), for: [])
                board[sender.tag - 1] = 2
                
                turn = 1
            }
            
            for win_cond in winning_conditions{
//                print("asdf" + String(board[win_cond[0]]) + "asdf")
                if board[win_cond[0]] != 0 && board[win_cond[0]] == board[win_cond[1]] && board[win_cond[1]] == board[win_cond[2]]
                {
                    print("Winning Case")
                    gameOver = true
                    lblGameStatus.text = "GAME END!"
                }
            }
            
            
//            self.view.backgroundColor = UIColor(patternImage: UIImage(named:String(randomImage()))!)
            
            print(board)
        }
        
    }
    
    func randomImage() -> String {
        var name: String = "bgi"
        var randomNo = arc4random() % 10
        return String(name + String(randomNo) + ".jpg")
    }
    
    
}

