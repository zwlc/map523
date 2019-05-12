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
    var racket: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var lifeLabel: SKLabelNode!
    var net: SKSpriteNode!
    var bomb: SKSpriteNode!
    
    var allScore: [Int] = []
    var finalScore: SKLabelNode!
    var score: Int = 0
    var life: Int = 3
    
    let ballCategory    :UInt32 = 0x1 << 1
    let racketCategory  :UInt32 = 0x1 << 2
    let netCategory     :UInt32 = 0x1 << 3
    
    let defaults = UserDefaults.standard // to save data
    
    var touchStart: CGPoint?
    var startTime: TimeInterval?
    
    override func didMove(to view: SKView) {
        
        allScore = defaults.object(forKey: "allScore") as? [Int] ?? [Int]()
        
        print("Start Gaming")
//        allScore.removeAll()
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 2
        self.physicsBody = border
        
        physicsWorld.contactDelegate = self
        backgroundColor = SKColor.green
        
        addRacket()
        addScoreLabel()
        addLifeLabel()
        addNet()
        addBomb()
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        ballTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(addBall), userInfo: nil, repeats: true)
        
    }
    
    @objc func addRacket(){
        racket = SKSpriteNode(imageNamed: "racket")
        racket.position = CGPoint(x: 0, y: -self.size.height / 2.5)
        racket.size = CGSize(width: 100, height: 100)
        racket.physicsBody = SKPhysicsBody(rectangleOf: racket.size)
        racket.physicsBody?.affectedByGravity = false
        racket.physicsBody?.mass = 10000
        racket.physicsBody?.categoryBitMask = racketCategory
        racket.physicsBody?.contactTestBitMask = ballCategory
        self.addChild(racket)
    }
    @objc func addScoreLabel(){
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.position = CGPoint(x: -210, y: 610)
        scoreLabel.fontSize = 36
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontColor = UIColor.white
        addChild(scoreLabel)
    }
    @objc func addLifeLabel(){
        lifeLabel = SKLabelNode(text: "Life: \(life)")
        lifeLabel.position = CGPoint(x:210,y:610)
        lifeLabel.fontName = "AmericanTypewriter-Bold"
        lifeLabel.fontSize = 36
        lifeLabel.fontColor = UIColor.white
        addChild(lifeLabel)
    }
    @objc func addNet(){
        net = childNode(withName: "net") as? SKSpriteNode
        net.physicsBody = SKPhysicsBody(rectangleOf: net.size)
        net.physicsBody?.affectedByGravity = false
        net.physicsBody?.mass = 10000
        net.physicsBody?.categoryBitMask = netCategory
        net.physicsBody?.contactTestBitMask = ballCategory
    }
    @objc func addBomb(){
        bomb = SKSpriteNode(imageNamed: "bomb")
        bomb.position = CGPoint(x: -300, y: -self.size.height / 2.5)
        bomb.size = CGSize(width: 50, height: 50)
        bomb.physicsBody = SKPhysicsBody(rectangleOf: bomb.size)
        bomb.physicsBody?.affectedByGravity = true
        bomb.physicsBody?.mass = 10000
        
        let action = SKAction.moveTo(y: 500, duration: 5)
        bomb.run(SKAction.repeatForever(action))
        
        self.addChild(bomb)
    }
    @objc func addBall(){
        let ball = SKSpriteNode(imageNamed: "ball1")
        ball.size = CGSize(width: 70, height: 70)
        
        let maxY = size.width / 2 - ball.size.width / 2
        let minY = -size.width / 2 + ball.size.width / 2
        let range = maxY - minY
        let ballY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        ball.position = CGPoint(x: ballY, y: size.height / 2 + ball.size.height / 2)
        
        let action = SKAction.moveTo(y: -(self.size.height / 2), duration: 1.5)
        ball.run(SKAction.repeatForever(action))
        
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = racketCategory | netCategory
        ball.physicsBody?.collisionBitMask = 1
        
        self.addChild(ball)
        
        var randomNumberForMove = CGFloat(arc4random_uniform(UInt32(range)))
        var moveDown = SKAction.moveBy(x: randomNumberForMove, y: 0, duration: 3.3)
        let mySeq = SKAction.sequence([moveDown, SKAction.removeFromParent()])
        ball.run(mySeq)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self)
        {
            let theNodes = nodes(at: location)
            for node in theNodes
            {
                if node.name == "play"
                {
                    score = 0
                    life = 3
                    node.removeFromParent()
                    scene?.isPaused = false
                    ballTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(addBall), userInfo: nil, repeats: true)
                    finalScore.removeFromParent()
                    //                    allScore.removeAll()
                }
            }
        }
        touchStart = touches.first?.location(in: self)
        startTime = touches.first?.timestamp
        for touch: AnyObject in touches
        {
            racket.position.x = touch.location(in: self).x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches
        {
            racket.position.x = touch.location(in: self).x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        scoreLabel.text = "Score: \(score)"
        lifeLabel.text = "Life: \(life)"
        if contact.bodyA.categoryBitMask == racketCategory && contact.bodyB.categoryBitMask == ballCategory
        {
            contact.bodyB.node?.removeFromParent()
            score += 1
        }
        if contact.bodyA.categoryBitMask == netCategory && contact.bodyB.categoryBitMask == ballCategory
        {
            contact.bodyB.node?.removeFromParent()
            if(life == 0)
            {
                gameOver()
            }
            life -= 1
        }
    }
    
    @objc func gameOver()
    {
        scene?.isPaused = true
        ballTimer?.invalidate()
        
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.size = CGSize(width: 200, height: 200)
        playButton.name = "play"
        playButton.zPosition = 1
        addChild(playButton)
        
        allScore.append(score)
        defaults.set(allScore, forKey: "allScore")
        print(defaults.object(forKey: "allScore") as? [Int] ?? [Int]())
        displayScores()
    }
    
    @objc func displayScores(){
        var finalString = "ALL SCORES \n"
        var p = 0
        while p < allScore.count{
            finalString.append(String(allScore[p]))
            finalString.append(",")
            p += 1
        }
        print(finalString)
        finalScore = SKLabelNode(text: "\(finalString)")
        finalScore.position = CGPoint(x:0,y:0)
        finalScore.fontName = "AmericanTypewriter-Bold"
        finalScore.fontColor = UIColor.white
        finalScore.fontSize = 36
        finalScore.numberOfLines = 10
        finalScore.fontColor = UIColor.white
        //        for index in allScore
        //        {
        ////            print("---")
        ////            print(allScore[index])
        ////            finalScore = SKLabelNode(text: "All Scores: \n \(allScore[index]) \n")
        //            finalScore.text = "All Scores: \n \(allScore[index]) \n"
        //        }
        addChild(finalScore)
    }
}
