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

//func +(left: CGPoint, right: CGPoint) -> CGPoint {
//    return CGPoint(x: left.x + right.x, y: left.y + right.y)
//}
//
//func -(left: CGPoint, right: CGPoint) -> CGPoint {
//    return CGPoint(x: left.x - right.x, y: left.y - right.y)
//}
//
//func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
//    return CGPoint(x: point.x * scalar, y: point.y * scalar)
//}
//
//func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
//    return CGPoint(x: point.x / scalar, y: point.y / scalar)
//}
//
//#if !(arch(x86_64) || arch(arm64))
//func sqrt(a: CGFloat) -> CGFloat {
//    return CGFloat(sqrtf(Float(a)))
//}
//#endif
//
//extension CGPoint {
//    func length() -> CGFloat {
//        return sqrt(x*x + y*y)
//    }
//
//    func normalized() -> CGPoint {
//        return self / length()
//    }
//}







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
    
    let defaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        
        
        allScore = defaults.object(forKey: "allScore") as? [Int] ?? [Int]()
        // defaults.removeObject(forKey: "allScore")  // Remove from UserDefaults
        //defaults.synchronize()
        print("game starting")
        
//        allScore.removeAll()
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
        
        //        let ball = SKSpriteNode(imageNamed: "ball")
        ////        let min = self.size.width / 8
        //        let min = self.size.width / 8
        //        let max = self.size.width - 20
        //        let point = UInt32(max-min)
        //
        //        //        ball.position = CGPoint(x : CGFloat(arc4random_uniform(point)), y: self.size.height)
        //        ball.position = CGPoint(x : CGFloat(arc4random_uniform(point)), y: self.size.height)
        //        print("point: " + String(point))
        //        print(ball.position)
        
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: 100, height: 100)
        
        let maxY = size.width / 2 - ball.size.width / 2
        let minY = -size.width / 2 + ball.size.width / 2
        let range = maxY - minY
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        ball.position = CGPoint(x: coinY, y: size.height / 2 + ball.size.height / 2)
        
//        print(ball.position)
        
        
        
        
        let action = SKAction.moveTo(y: -(self.size.height / 2), duration: 3.0)
        ball.run(SKAction.repeatForever(action))
        
        
        //        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        //        let position = CGFloat(randomAlienPosition.nextInt())
        //
        //        alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)
        
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = racketCategory | netCategory
        ball.physicsBody?.collisionBitMask = 0
        
        self.addChild(ball)
        
        //        let animationDuration:TimeInterval = 6
        //
        //        var actionArray = [SKAction]()
        // actionArray.append(SKAction.move(to: CGPoint(x: position, y: -alien.size.height*20), duration: animationDuration))
        //  actionArray.append(SKAction.removeFromParent())
        
        //  alien.run(SKAction.sequence(actionArray))
        let moveDown = SKAction.moveBy(x: 0, y: 0, duration: 3.3)
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
                }
            }
        }
        
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

