//
//  GameViewController.swift
//  SpriteDrop
//
//  Created by Owner on 03/09/18.
//  Copyright © 2018 Edoardo Francesco Amedeo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var leafView: LeafView?
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
           
                
            }
            
            setupConfetti()
            leafView?.startLeaf()
            
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            
        }
    }
    
    
    var shapes = ["EmptyOvalFall", "EmptyTriangleFall", "EmptySquareFall"]
    func setupConfetti() {
        leafView = LeafView(frame: self.view.frame)
        leafView!.direction = .top
        leafView!.intensity = 0.05
        self.view.addSubview((leafView)!)
        leafView!.isUserInteractionEnabled = false
        leafView?.setImageForLeaf(imageLeaf: UIImage(named: "EmptyOvalFall")!)
        
    }
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
