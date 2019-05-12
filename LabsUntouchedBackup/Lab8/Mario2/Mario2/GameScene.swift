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
    
    var mario: SKSpriteNode?  //SKSpriteNode is an onscreen graphical element that can be initialized from an image or a solid color. SpriteKit adds functionality to its ability to display images. For more information:
    //https://developer.apple.com/documentation/spritekit/skspritenode
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self  //The driver of the physics engine in a scene; it exposes the ability for you to configure and query the physics system.
       
        mario = childNode(withName: "mario") as? SKSpriteNode
        
        let swipeLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedLeft))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedRight))
         let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedUp))
        
        swipeRight.direction = .right
        swipeLeft.direction = .left
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeUp)
        let panRecognizer = UIPanGestureRecognizer(target: self, action:  #selector(panedView))
        self.view!.addGestureRecognizer(panRecognizer)
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer) {
        print("Object has been swiped Right");
        mario?.physicsBody?.applyForce(CGVector(dx:5000, dy: 40000))
       // let p = location(UISwipeGestureRecognizer)
       // print(p)
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {

        print("Object has been swiped Left")
        mario?.physicsBody?.applyForce(CGVector(dx:-5000, dy: 40000))
    }
    
    @objc func swipedUp(sender: UISwipeGestureRecognizer) {
        
        print("Object has been swiped Up")
        mario?.physicsBody?.applyForce(CGVector(dx:0, dy: 40000))
    }
    
     @objc func panedView(sender:UIPanGestureRecognizer){
        var startLocation = CGPoint()
        if (sender.state == UIGestureRecognizer.State.began) {
            startLocation = sender.location(in: self.view)
        }
        else if (sender.state == UIGestureRecognizer.State.ended) {
            let stopLocation = sender.location(in: self.view)
            let dx = stopLocation.x - startLocation.x;
            let dy = stopLocation.y - startLocation.y;
            let distance = sqrt(dx*dx + dy*dy );
            NSLog("Distance: %f", distance);
        }
    }
}

