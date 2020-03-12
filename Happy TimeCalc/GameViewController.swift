//
//  GameViewController.swift
//  Happy TimeCalc
//
//  Created by David Pai on 2020/2/28.
//  Copyright © 2020 Pai Bros. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var currentGame: GameScene!
    
    @IBOutlet var hr1: UITextField!
    @IBOutlet var min1: UITextField!
    @IBOutlet var sec1: UITextField!
    @IBOutlet var hr2: UITextField!
    @IBOutlet var min2: UITextField!
    @IBOutlet var sec2: UITextField!
    @IBOutlet var hrResult: UILabel!
    @IBOutlet var minResult: UILabel!
    @IBOutlet var secResult: UILabel!
    
    var focused: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            focused = hr1
        }
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
    
    @IBAction func timeFieldFocused(_ sender: UITextField) {
        print("Focus on \(sender)")
        sender.text! = ""
        self.focused = sender
    }
    
}
