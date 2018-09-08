//
//  RainDrop.swift
//  SpriteDrop
//
//  Created by Owner on 03/09/18.
//  Copyright © 2018 Edoardo Francesco Amedeo. All rights reserved.
//

import SpriteKit

class SquareDrop: SKShapeNode {
    init(color: UIColor) {
        super.init()

        let path = CGMutablePath()
        path.addRect(CGRect(x: 0.5, y: 0, width: 120, height: 120))
        self.position = CGPoint(x: frame.midX, y: UIScreen.main.bounds.height/2)
        self.path = path
        self.strokeColor = .white
        self.fillColor = color
        self.lineWidth = 5
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        self.physicsBody?.linearDamping = 5
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = PhysicsCategory.squareCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.squareCategory
    }
    
    
    func move(touchLocation: CGPoint) {
       if self.calculateAccumulatedFrame().contains(touchLocation) {
            self.position.x = touchLocation.x
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
