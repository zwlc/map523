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
    var lifeLabel: SKLabelNode?
    var l1: SKSpriteNode?
    var l2: SKSpriteNode?
    var l3: SKSpriteNode?
    
    var mario: SKSpriteNode?  //SKSpriteNode is an onscreen graphical element that can be initialized from an image or a solid color. SpriteKit adds functionality to its ability to display images. For more information:
    //https://developer.apple.com/documentation/spritekit/skspritenode
    
    
    var coinTimer: Timer?
    var cloudTimer: Timer?
    var bombTimer: Timer?
    var score = 0
    var life = 3
    
    let marioCategory: UInt32 = 0x1 << 1
    let coinCategory: UInt32 = 0x1 << 2
    let cloudCategory: UInt32 = 0x1 << 3
    let bombCategory: UInt32 = 0x1 << 4
    
    override func didMove(to view: SKView) {
        
        
        physicsWorld.contactDelegate = self  //The driver of the physics engine in a scene; it exposes the ability for you to configure and query the physics system.
       
        mario = childNode(withName: "mario") as? SKSpriteNode
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        lifeLabel = childNode(withName: "lifeLabel") as? SKLabelNode
        l1 = childNode(withName: "l1") as? SKSpriteNode
        l2 = childNode(withName: "l2") as? SKSpriteNode
        l3 = childNode(withName: "l3") as? SKSpriteNode
        

        mario?.physicsBody?.categoryBitMask = marioCategory
        mario?.physicsBody?.contactTestBitMask = coinCategory | bombCategory
        
        coinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in self.createCoin()})
        
        cloudTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {(timer) in self.createCloud()})
        
        bombTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {(timer) in self.createBomb()})
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
        
        coin.physicsBody?.collisionBitMask = 0
        
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
    
    func createCloud()
    {
        let cloud = SKSpriteNode(imageNamed: "cloud")
        cloud.size = CGSize(width: 400, height: 200)
        //cloud.physicsBody = SKPhysicsBody(rectangleOf: cloud.size)
        cloud.physicsBody?.affectedByGravity = false
        
        cloud.physicsBody?.categoryBitMask = cloudCategory
        cloud.physicsBody?.collisionBitMask = 0
        
        addChild(cloud)
        
        let maxY = size.height / 2 - cloud.size.height / 2
        let minY = -size.height / 2 + cloud.size.height / 2
        let range = maxY - minY
        
        let cloudY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        cloud.position = CGPoint(x: size.width / 2 + cloud.size.width / 2, y: cloudY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - cloud.size.width, y: 0, duration: 4)
        let mySeq = SKAction.sequence([moveLeft, SKAction.removeFromParent()])
        cloud.run(mySeq)
        
    }
    
    func createBomb()
    {
        let bomb = SKSpriteNode(imageNamed: "bomb")
        bomb.size = CGSize(width: 100, height: 100)
        bomb.physicsBody = SKPhysicsBody(rectangleOf: bomb.size)
        bomb.physicsBody?.affectedByGravity = false
        
        bomb.physicsBody?.categoryBitMask = bombCategory
        bomb.physicsBody?.collisionBitMask = 0
        
        addChild(bomb)
        
        let maxY = size.height / 2 - bomb.size.height / 2
        let minY = -size.height / 2 + bomb.size.height / 2
        let range = maxY - minY
        
        let bombY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        bomb.position = CGPoint(x: size.width / 2 + bomb.size.width / 2, y: bombY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - bomb.size.width, y: 0, duration: 4)
        let mySeq = SKAction.sequence([moveLeft, SKAction.removeFromParent()])
        bomb.run(mySeq)
        
    }
    
    func gameOver() {
        
        scene?.isPaused = true

        coinTimer?.invalidate()
        bombTimer?.invalidate()

        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.name = "play"
        playButton.zPosition = 1
        addChild(playButton)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact!")
        
        scoreLabel?.text = "Score: \(score)"

        if contact.bodyB.categoryBitMask == coinCategory {
            contact.bodyB.node?.removeFromParent()
            score += 1
        }
        
        if contact.bodyB.categoryBitMask == bombCategory {
            contact.bodyB.node?.removeFromParent()
            life = life - 1
            if(life == 2)
            {
                l1?.removeFromParent()
            }
            if(life == 1)
            {
                l2?.removeFromParent()
            }
            if(life == 0)
            {
                l3?.removeFromParent()
                gameOver()
            }
        }
    }
    
}
