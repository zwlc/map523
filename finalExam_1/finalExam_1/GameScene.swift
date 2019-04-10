//
//  GameScene.swift
//  finalExam_1
//
//  Created by Mason Ko on 2019-04-10.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

// student name: Youngmin Ko
// student ID: 019155159

import SpriteKit
import GameplayKit
import CoreMotion // i don't know what is it but it seems like about physics. so i import it anyways
import CoreData   // to save data

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ballTimer: Timer!
    var racket: SKSpriteNode!
    var net1: SKSpriteNode!
    var net2: SKSpriteNode!
    var net3: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var lifeLabel: SKLabelNode!
    
    var allScore: [Int] = []
    var finalScore: SKLabelNode!
    var score : Int = 0
    var life = 3
    
    let racketCategory  :UInt32 = 0x1 << 0
    let ball1Category    :UInt32 = 0x1 << 1
    let ball2Category    :UInt32 = 0x1 << 2
    let ball3Category    :UInt32 = 0x1 << 3
    let net1Category     :UInt32 = 0x1 << 4
    let net2Category     :UInt32 = 0x1 << 5
    let net3Category     :UInt32 = 0x1 << 6
    
    var touchStart: CGPoint?
    var startTime : TimeInterval?
    
    let defaults = UserDefaults.standard // to save data
    
    var possibleBall = ["A","B","C","D","E","F","G","I"]
    
    override func didMove(to view: SKView) {
        print("GAME STARTED")
        
        physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.darkGray
        
        addRacket()
        addScoreLabel()
        addLifeLabel()
        addNet1()
        addNet2()
        addNet3()
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        ballTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(addBall), userInfo: nil, repeats: true)
    }
    @objc func addRacket(){
        racket = SKSpriteNode(imageNamed: "racket")
        //        racket.position = CGPoint(x: 0, y: -self.size.height / 2.5)
        racket.position = CGPoint(x: 0, y: -50)
        racket.size = CGSize(width: 50, height: 350)
        racket.physicsBody = SKPhysicsBody(rectangleOf: racket.size)
        racket.physicsBody?.affectedByGravity = false
        racket.physicsBody?.mass = 10000
        racket.physicsBody?.categoryBitMask = racketCategory
        racket.physicsBody?.contactTestBitMask = ball1Category
        racket.physicsBody?.contactTestBitMask = ball2Category
        racket.physicsBody?.contactTestBitMask = ball3Category
        self.addChild(racket)
    }
    @objc func addScoreLabel(){
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.position = CGPoint(x:-210,y:610)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
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
    @objc func addNet1(){
        net1 = childNode(withName: "net1") as? SKSpriteNode
        net1.physicsBody = SKPhysicsBody(rectangleOf: net1.size)
        net1.physicsBody?.affectedByGravity = false
        net1.physicsBody?.mass = 1000000
        net1.physicsBody?.categoryBitMask = net1Category
        net1.physicsBody?.contactTestBitMask = ball1Category
        //        net1.physicsBody?.contactTestBitMask = ball2Category
        //        net1.physicsBody?.contactTestBitMask = ball3Category
    }
    @objc func addNet2(){
        net2 = childNode(withName: "net2") as? SKSpriteNode
        net2.physicsBody = SKPhysicsBody(rectangleOf: net2.size)
        net2.physicsBody?.affectedByGravity = false
        net2.physicsBody?.mass = 1000000
        net2.physicsBody?.categoryBitMask = net2Category
        net2.physicsBody?.contactTestBitMask = ball2Category
        //        net2.physicsBody?.contactTestBitMask = ball1Category
        //        net2.physicsBody?.contactTestBitMask = ball3Category
    }
    @objc func addNet3(){
        net3 = childNode(withName: "net3") as? SKSpriteNode
        net3.physicsBody = SKPhysicsBody(rectangleOf: net3.size)
        net3.physicsBody?.affectedByGravity = false
        net3.physicsBody?.mass = 1000000
        net3.physicsBody?.categoryBitMask = net3Category
        net3.physicsBody?.contactTestBitMask = ball3Category
        //        net3.physicsBody?.contactTestBitMask = ball1Category
        //        net3.physicsBody?.contactTestBitMask = ball2Category
    }
    @objc func addBall () {
        possibleBall = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleBall) as! [String]
        print(possibleBall)
        
        let ball = SKSpriteNode(imageNamed: possibleBall[0])
        ball.size = CGSize(width: 50, height: 50)
        let maxY = size.width / 2 - ball.size.width / 2
        let minY = -size.width / 2 + ball.size.width / 2
        let range = maxY - minY
        let charY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        ball.position = CGPoint(x: charY, y: size.height / 2 + ball.size.height / 2)
        let action = SKAction.moveTo(y: -(self.size.height / 2), duration: 5)
        ball.run(SKAction.repeatForever(action))
        
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        if possibleBall[0] == "A" || possibleBall[0] == "B" || possibleBall[0] == "C"
        {
            ball.physicsBody?.categoryBitMask = ball1Category
        }
        if possibleBall[0] == "D" || possibleBall[0] == "E" || possibleBall[0] == "F"
        {
            ball.physicsBody?.categoryBitMask = ball2Category
        }
        if possibleBall[0] == "G" || possibleBall[0] == "H" || possibleBall[0] == "I"
        {
            ball.physicsBody?.categoryBitMask = ball3Category
        }
        ball.physicsBody?.contactTestBitMask = racketCategory
        ball.physicsBody?.collisionBitMask = 1
        
        self.addChild(ball)
        let moveDown = SKAction.moveBy(x: 0, y: 0, duration: 10)
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
        
        
        if contact.bodyA.categoryBitMask == net1Category && contact.bodyB.categoryBitMask == ball1Category
        {
            contact.bodyB.node?.removeFromParent()
            score += 1
        }
        else if contact.bodyA.categoryBitMask == net2Category && contact.bodyB.categoryBitMask == ball2Category
        {
            contact.bodyB.node?.removeFromParent()
            score += 1
        }
        else if contact.bodyA.categoryBitMask == net3Category && contact.bodyB.categoryBitMask == ball3Category
        {
            contact.bodyB.node?.removeFromParent()
            score += 1
        }
        else
        {
            life -= 1
            if(life < 1)
            {
                gameOver()
            }
            
        }
        scoreLabel.text = "Score: \(score)"
        lifeLabel.text = "Life: \(life)"
        
    }
    
    func gameOver() {
        
        
        scene?.isPaused = true
        
        ballTimer?.invalidate()
        
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.size = CGSize(width: 200, height: 200)
        playButton.name = "play"
        playButton.zPosition = 1
        addChild(playButton)
        
        allScore.append(score)
        defaults.set(allScore, forKey: "allScore") // saving
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
    //    func touchDown(atPoint pos : CGPoint) {
    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
    //            n.position = pos
    //            n.strokeColor = SKColor.green
    //            self.addChild(n)
    //        }
    //    }
    //
    //    func touchMoved(toPoint pos : CGPoint) {
    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
    //            n.position = pos
    //            n.strokeColor = SKColor.blue
    //            self.addChild(n)
    //        }
    //    }
    //
    //    func touchUp(atPoint pos : CGPoint) {
    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
    //            n.position = pos
    //            n.strokeColor = SKColor.red
    //            self.addChild(n)
    //        }
    //    }
    //
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        if let label = self.label {
    //            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
    //        }
    //
    //        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    //    }
    //
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    //    }
    //
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    //    }
    //
    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    //    }
    
    
}
