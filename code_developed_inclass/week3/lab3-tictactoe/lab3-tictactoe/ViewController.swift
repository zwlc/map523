//
//  ViewController.swift
//  lab3-tictactoe
//
//  Created by Mason Ko on 2019-04-08.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbl_gameStatus: UILabel!
    
    var gameOver = false
    var turn = 1 // 1 = O, 2 = X
    var board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningConditions =
        [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    
    @IBAction func btnPressed(_ sender: UIButton) {
        print(sender.tag)
        if board[sender.tag - 1] == 0 && gameOver != true
        {
            if turn == 1
            {
                sender.setImage(UIImage(named: "nought"), for: [])
                board[sender.tag - 1] = 1
                turn = 2
            }
            else
            {
                sender.setImage(UIImage(named: "cross"), for: [])
                board[sender.tag - 1] = 2
                turn = 1
            }
            for win_cond in winningConditions
            {
                if board[win_cond[0]] != 0 && board[win_cond[0]] == board[win_cond[1]] && board[win_cond[1]] == board[win_cond[2]]
                {
                    print("Winning Case")
                    gameOver = true
                    lbl_gameStatus.text = "GAME END!"
                }
            }
        }
        print(board)
    }
    
}

