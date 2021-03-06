//
//  GameScene.swift
//  Mario2
//
//  Created by Alireza Moghaddam on 2019-02-02.
//  Copyright © 2019 Alireza. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    var scoreLabel: SKLabelNode?
    
    var mario: SKSpriteNode?  //SKSpriteNode is an onscreen graphical element that can be initialized from an image or a solid color. SpriteKit adds functionality to its ability to display images. For more information:
    //https://developer.apple.com/documentation/spritekit/skspritenode
    
    
    var coinTimer: Timer?
   
    var score = 0
    
    let marioCategory: UInt32 = 0x1 << 1
    let coinCategory: UInt32 = 0x1 << 2
    
    
    override func didMove(to view: SKView) {
        
        
        physicsWorld.contactDelegate = self  //The driver of the physics engine in a scene; it exposes the ability for you to configure and query the physics system.
       
        mario = childNode(withName: "mario") as? SKSpriteNode
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        
        
        mario?.physicsBody?.categoryBitMask = marioCategory
        mario?.physicsBody?.contactTestBitMask = coinCategory
        
        
        coinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in self.createCoin()})
        
      
        
       
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        mario?.physicsBody?.applyForce(CGVector(dx:0, dy: 50000))
        
    }
    
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.size = CGSize(width: 100, height: 100)
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.affectedByGravity = false
        
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = marioCategory
        
        //coin.physicsBody?.collisionBitMask = 0
        
        addChild(coin)
        
        let maxY = size.height / 2 - coin.size.height / 2
        let minY = -size.height / 2 + coin.size.height / 2
        let range = maxY - minY
        
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        coin.position = CGPoint(x: size.width / 2 + coin.size.width / 2, y: coinY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        let mySeq = SKAction.sequence([moveLeft, SKAction.removeFromParent()])
        coin.run(mySeq)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact!")
        
        scoreLabel?.text = "Score: \(score)"
        
        /*
        if contact.bodyA.categoryBitMask == coinCategory {
            contact.bodyA.node?.removeFromParent()
        }
        */
        
        if contact.bodyB.categoryBitMask == coinCategory {
            contact.bodyB.node?.removeFromParent()
            score += 1
        }
 
        
        
    }
    
  
}
