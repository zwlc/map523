//
//  GameScene.swift
//  finalMockup_2_redo
//
//  Created by Mason Ko on 2019-04-10.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import CoreData

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ballTimer: Timer!
    var rocket: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var lifeLabel: SKLabelNode!
    var net: SKSpriteNode!
    var bomb: SKSpriteNode!
    
    var allScore: [Int] = []
    var finalScore: SKLabelNode
    var score: Int = 0
    var life: Int = 3
    
    let ballCategory    :UInt32 = 0x1 << 1
    let rocketCategory  :UInt32 = 0x1 << 2
    let netCategory     :UInt32 = 0x1 << 3
    
    let defaults = UserDefaults.standard // to save data
    
    var touchStart: CGPoint?
    var startTime: TimeInterval?
    let minSpeed:CGFloat = 10000
    
}
