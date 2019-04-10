//
//  GameScene.swift
//  finalMockup
//
//  Created by Mason Ko on 2019-04-09.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion // i don't know what is it but it seems like about physics. so i import it anyways
import CoreData   // to save data

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var ballTimer: Timer!
    var racket: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var lifeLabel: SKLabelNode!
    var net: SKSpriteNode!
    var allScore: [Int] = []
    var finalScore: SKLabelNode!
    
    var score : Int = 0
    var life = 3
    
    let ballCategory    :UInt32 = 0x1 << 1
    let racketCategory  :UInt32 = 0x1 << 0
    let netCategory     :UInt32 = 0x1 << 2
    
    let defaults = UserDefaults.standard // to save data
    
    var touchStart: CGPoint?
    var startTime : TimeInterval?
    let minSpeed:CGFloat = 10000
    let maxSpeed:CGFloat = 50000
    let minDistance:CGFloat = 25
    let minDuration:TimeInterval = 0.1
    
    override func didMove(to view: SKView) {
        
        allScore = defaults.object(forKey: "allScore") as? [Int] ?? [Int]()
        // defaults.removeObject(forKey: "allScore")  // Remove from UserDefaults
        //defaults.synchronize()
        print("game starting")
        
        // about resetting, removing, empty array
//        allScore.removeAll()
        
        // about border start
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        // about border end
        
        physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.darkGray
        
        addRacket()
        addScoreLabel()
        addLifeLabel()
        addNet()

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        ballTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(addBall), userInfo: nil, repeats: true)
    }
    
    @objc func addRacket(){
        racket = SKSpriteNode(imageNamed: "racket")
        racket.position = CGPoint(x: 0, y: -self.size.height / 2.5)
        racket.size = CGSize(width: 100, height: 100)
        racket.position = CGPoint(x: 0, y: -self.size.height/2.5)
        racket.physicsBody = SKPhysicsBody(rectangleOf: racket.size)
        racket.physicsBody?.affectedByGravity = false
        racket.physicsBody?.mass = 10000
        racket.physicsBody?.categoryBitMask = racketCategory
        racket.physicsBody?.contactTestBitMask = ballCategory
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
    @objc func addNet(){
        net = childNode(withName: "net") as? SKSpriteNode
        net.physicsBody = SKPhysicsBody(rectangleOf: net.size)
        net.physicsBody?.affectedByGravity = false
        net.physicsBody?.mass = 10000
        net.physicsBody?.categoryBitMask = netCategory
        net.physicsBody?.contactTestBitMask = ballCategory
    }
    
    
    @objc func addBall () {
        
        let ball = SKSpriteNode(imageNamed: "ball1")
        
        // about animation start
        var ballRun : [SKTexture] = []
        for number in 1...2
        {
            ballRun.append(SKTexture(imageNamed: "ball\(number).png"))
        }
        ball.run(SKAction.repeatForever(SKAction.animate(with: ballRun, timePerFrame: 0.2)))
        // about animation end
        
        ball.size = CGSize(width: 70, height: 70)
        
        // about random location ball spawn and drop start
        let maxY = size.width / 2 - ball.size.width / 2
        let minY = -size.width / 2 + ball.size.width / 2
        let range = maxY - minY
        let ballY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
//        print(ballY)
        ball.position = CGPoint(x: ballY, y: size.height / 2 + ball.size.height / 2)
        // about random location ball spawn and drop end
//        print(ball.position)
        
        let action = SKAction.moveTo(y: -(self.size.height / 2), duration: 1.5)
        ball.run(SKAction.repeatForever(action))
        
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = racketCategory | netCategory
        ball.physicsBody?.collisionBitMask = 1
        
        self.addChild(ball)
        var randomNumberForMove = CGFloat(arc4random_uniform(UInt32(range)))
        let moveDown = SKAction.moveBy(x: randomNumberForMove, y: 0, duration: 3.3)
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
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touchStart = self.touchStart else {
//            return
//        }
//        guard let startTime = self.startTime else {
//            return
//        }
//        guard let location = touches.first?.location(in: self) else {
//            return
//        }
//        guard let time = touches.first?.timestamp else {
//            return
//        }
//        var dx = location.x - touchStart.x
//        var dy = location.y - touchStart.y
//        // Distance of the gesture
//        let distance = sqrt(dx*dx+dy*dy)
//        if distance >= minDistance {
//            // Duration of the gesture
//            let deltaTime = time - startTime
//            if deltaTime > minDuration {
//                // Speed of the gesture
//                let speed = distance / CGFloat(deltaTime)
//                if speed >= minSpeed && speed <= maxSpeed {
//                    // Normalize by distance to obtain unit vector
//                    dx /= distance
//                    dy /= distance
//                    // Swipe detected
//                    print("Swipe detected with speed = \(speed) and direction (\(dx), \(dy)")
//                }
//            }
//        }
//        //        // Reset variables
//        //        touchStart = nil
//        //        startTime = nil
//        racket?.physicsBody?.applyForce(CGVector(dx: dx*100, dy: dy*100)) //jumping
//    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches
        {
            racket.position.x = touch.location(in: self).x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        scoreLabel.text = "Score: \(score)"
        lifeLabel.text = "Life: \(life)"
        if contact.bodyA.categoryBitMask == racketCategory && contact.bodyB.categoryBitMask == ballCategory {
            contact.bodyB.node?.removeFromParent()
            score += 1
        }
        
        if contact.bodyA.categoryBitMask == netCategory && contact.bodyB.categoryBitMask == ballCategory {
            contact.bodyB.node?.removeFromParent()
            if(life == 0){
                gameOver()
            }
            life -= 1
            
        }

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
}

