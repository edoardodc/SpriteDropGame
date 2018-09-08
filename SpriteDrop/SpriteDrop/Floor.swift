//
//  Floor.swift
//  SpriteDrop
//
//  Created by Owner on 03/09/18.
//  Copyright © 2018 Edoardo Francesco Amedeo. All rights reserved.
//

import SpriteKit
import Foundation

class Floor: SKNode {
    
    override init() {
        super.init()
        self.position = CGPoint(x:0, y: -UIScreen.main.bounds.height/2)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: UIScreen.main.bounds.width * 2, height: 25))
        self.physicsBody?.isDynamic = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.floorCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.squareCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
