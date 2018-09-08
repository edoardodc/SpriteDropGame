//
//  GameScene.swift
//  SpriteDrop
//
//  Created by Owner on 03/09/18.
//  Copyright © 2018 Edoardo Francesco Amedeo. All rights reserved.
//

import SpriteKit
import GameplayKit

public struct PhysicsCategory {
    static let squareCategory   : UInt32 = 0x1
    static let floorCategory    : UInt32 = 0x10
    static let none             : UInt32 = 0
}

class GameScene: SKScene {
    
    let floor = Floor()
    var square: SquareDrop?
    var movableNode: SKNode?
    var color = [#colorLiteral(red: 0.2509803922, green: 0.3243751277, blue: 0.8180881076, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
    var touchLocation = CGPoint()
    public var score = 0

    override func didMove(to view: SKView) {

        self.addChild(floor)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.137254902, blue: 0.6117647059, alpha: 1)

        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(spawnSquare),
                SKAction.wait(forDuration: 2.0)
            ])
        ))
    }
    
    func projectileDidCollideWithMonster(square1: SKShapeNode, square2: SKShapeNode) {
        if square1.fillColor == square2.fillColor {
            square1.removeFromParent()
            square2.removeFromParent()
            score += 1
        }
    }
    
    func spawnSquare() {
        square = SquareDrop(color: color.randomElement()!)
        self.addChild(square!)
    }
    
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.location(in: self)
            square?.position.x = (touchLocation.x)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        square?.position.x = (touchLocation.x)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            movableNode = nil
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    override func update(_ currentTime: TimeInterval) {}
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.squareCategory && contact.bodyB.categoryBitMask == PhysicsCategory.squareCategory {
        
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            let sq1 = firstBody.node as? SKShapeNode
            let sq2 = secondBody.node as? SKShapeNode
            projectileDidCollideWithMonster(square1: sq1!, square2: sq2!)
            
            
        }else if contact.bodyB.categoryBitMask == PhysicsCategory.squareCategory && contact.bodyA.categoryBitMask == PhysicsCategory.floorCategory {
            
        }
    }
}
