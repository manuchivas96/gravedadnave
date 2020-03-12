//
//  GameScene.swift
//  game
//
//  Created by CEDAM 25 on 26/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import SpriteKit
import CoreMotion


class Ball: SKSpriteNode{ }

class GameScene: SKScene {
    var motionManager: CMMotionManager?
    var balls = ["e1","e2"]
    
    let scoreLabel = SKLabelNode(fontNamed: "Score")
    var matcheBalls = Set<Ball>()
    var score = 0{
        didSet{
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formatteScore = formatter.string(from: score as NSNumber) ?? "0"
            scoreLabel.text = "Score:\(formatteScore)"
        }
    }
    override func didMove(to view: SKView) {
        let back = SKSpriteNode(imageNamed: "fondo")
        back.position = CGPoint(x:frame.size.width/2, y: frame.midY)
        back.alpha = 0.2
        back.zPosition = -1
        addChild(back)
        
        scoreLabel.fontSize = 72
        scoreLabel.position = CGPoint(x: 20, y: 20)
        scoreLabel.text = "Score: 0"
        scoreLabel.zPosition = 100
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        let ball = SKSpriteNode(imageNamed: "e1")
        let ballRadius = ball.frame.width/2.0
        for i in stride(from:ballRadius, to: view.bounds.width - ballRadius, by: ball.frame.width){
            for j in stride(from:50, to: view.bounds.height - ballRadius, by: ball.frame.height){
                let ballType = balls.randomElement()!
                let bolas = Ball(imageNamed: ballType)
                bolas.size = CGSize(width:20, height:20)
                bolas.position = CGPoint(x: i, y: j)
                bolas.name = ballType
                bolas.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
                bolas.physicsBody?.allowsRotation = false
                bolas.physicsBody?.restitution = 0
                bolas.physicsBody?.friction = 0
                addChild(bolas)
            }
            
        }
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)))
       motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    
    }
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager?.accelerometerData{
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * +50)
        }
    }
    
    func getMatches(from node:Ball){
        for body in node.physicsBody!.allContactedBodies(){
            guard let ball = body.node as? Ball else { continue}
            guard ball.name == node.name else {continue}
            if !matcheBalls.contains(ball){
                matcheBalls.insert(ball)
                getMatches(from: ball)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let position = touches.first?.location(in: self) else {return}
        guard let tappedBall = nodes(at:position).first(where:{ $0 is Ball}) as? Ball else {return}
        matcheBalls.removeAll(keepingCapacity: true)
        getMatches(from: tappedBall)
        if matcheBalls.count >= 3 {
            for ball in matcheBalls{
                ball.removeFromParent()
            }
        }
        
    }
     
    
    
    
    
    
}
