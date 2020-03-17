//
//  GameScene.swift
//  Happy TimeCalc
//
//  Created by David Pai on 2020/2/28.
//  Copyright © 2020 Pai Bros. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    weak var viewController: GameViewController!
    
    /*private*/ var keyboardNode: SKSpriteNode?
    /*private*/ var smallKeyboardNode: SKSpriteNode?
    /*private*/ var labelNode: SKLabelNode?
    /*private*/ var oneNode: SKSpriteNode?
    /*private*/ var twoNode: SKSpriteNode?
    /*private*/ var threeNode: SKSpriteNode?
    /*private*/ var fourNode: SKSpriteNode?
    /*private*/ var fiveNode: SKSpriteNode?
    /*private*/ var sixNode: SKSpriteNode?
    /*private*/ var sevenNode: SKSpriteNode?
    /*private*/ var eightNode: SKSpriteNode?
    /*private*/ var nineNode: SKSpriteNode?
    /*private*/ var zeroNode: SKSpriteNode?
    /*private*/ var clearNode: SKSpriteNode?
    
    var isMoved: Bool = false
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.keyboardNode = self.childNode(withName: "//keyboard") as? SKSpriteNode
        self.smallKeyboardNode = self.childNode(withName: "//small-keyboard") as? SKSpriteNode
        self.oneNode = self.keyboardNode?.childNode(withName: "//1") as? SKSpriteNode
        self.twoNode = self.keyboardNode?.childNode(withName: "//2") as? SKSpriteNode
        self.threeNode = self.keyboardNode?.childNode(withName: "//3") as? SKSpriteNode
        self.fourNode = self.keyboardNode?.childNode(withName: "//4") as? SKSpriteNode
        self.fiveNode = self.keyboardNode?.childNode(withName: "//5") as? SKSpriteNode
        self.sixNode = self.keyboardNode?.childNode(withName: "//6") as? SKSpriteNode
        self.sevenNode = self.keyboardNode?.childNode(withName: "//7") as? SKSpriteNode
        self.eightNode = self.keyboardNode?.childNode(withName: "//8") as? SKSpriteNode
        self.nineNode = self.keyboardNode?.childNode(withName: "//9") as? SKSpriteNode
        self.zeroNode = self.keyboardNode?.childNode(withName: "//0") as? SKSpriteNode
        clearNode = keyboardNode?.childNode(withName: "//C") as? SKSpriteNode
                
//        self.oneNode?.size = CGSize(width: 200, height: 50)
//        self.keyboardNode?.zPosition = -1
        
        smallKeyboardNode?.isHidden = true
        
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
        
        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
//        view.addGestureRecognizer(recognizer)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
//        print(keyboardNode?.position)
//        keyboardNode?.anchorPoint = CGPoint(x: 0, y: 1)
//        keyboardNode?.position = keyboardNode!.anchorPoint
//        print(keyboardNode?.position)
//
//        print("First: \(touches.first?.location(in: self))")
//        print("Frame: \(view?.frame.size)")
//
//        for t in touches {
//            print("t.x: \(t.location(in: self).x),t.y: \(t.location(in: self).y)")
//            print("k.x: \(t.location(in: keyboardNode!).x),k.y: \(t.location(in: keyboardNode!).y)")
//            let apX = (t.location(in: self).x + ((keyboardNode?.frame.width)! / 2)) / (keyboardNode?.frame.width)!
//            let apY = (t.location(in: self).y + ((keyboardNode?.frame.height)! / 2)) / (keyboardNode?.frame.height)!
//            print("apX: \(apX), apY: \(apY)")
//            keyboardNode?.anchorPoint = CGPoint(x: apX, y: apY)
//        }
        
//        keyboardNode?.isHidden = true
//        smallKeyboardNode?.isHidden = false
//        smallKeyboardNode?.position = keyboardNode!.position
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("\(keyboardNode?.frame.size)")
//        print("Location in view: \(touches.first?.location(in: self))")
//        print("Location in keyboard: \(touches.first?.location(in: keyboardNode!))")
        isMoved = true
        keyboardNode?.isHidden = true
        smallKeyboardNode?.isHidden = false
        smallKeyboardNode?.position = keyboardNode!.position
        
        for t in touches {
            if (self.keyboardNode?.contains(t.location(in: self)))! {
//                keyboardNode?.anchorPoint = t.location(in: self)
                
                
//                let apX = (t.location(in: self).x + ((keyboardNode?.frame.width)! / 2)) / (keyboardNode?.frame.width)!
//                let apY = (t.location(in: self).y + ((keyboardNode?.frame.height)! / 2)) / (keyboardNode?.frame.height)!
//                print("\(apX), \(apY)")
//                keyboardNode?.anchorPoint = CGPoint(x: apX, y: apY)
                
//                self.keyboardNode?.position = t.location(in: self)
                
//                keyboardNode?.anchorPoint = CGPoint(x: 0, y: 0)
                let moveAction = SKAction.move(to: CGPoint(x: t.location(in: self).x, y: t.location(in: self).y), duration: 0.1)
                keyboardNode?.run(moveAction)
                smallKeyboardNode?.run(moveAction)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isMoved {
            for t in touches {
                if self.viewController.focusedLabel?.text == "00" {
                    self.viewController.focusedLabel?.text = ""
                }
                
                var number = self.viewController.focusedLabel?.text
                
                if ((self.oneNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.oneNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.twoNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.twoNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.threeNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.threeNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.fourNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.fourNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.fiveNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.fiveNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.sixNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.sixNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.sevenNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.sevenNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.eightNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.eightNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.nineNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.nineNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
                else if ((self.zeroNode?.contains(t.location(in: self.keyboardNode!)))!) {
                    number! += self.zeroNode!.name!
                    self.viewController.focusedLabel?.text = number
                }
            }
            
            self.viewController.validate(number: self.viewController.focusedLabel!.text!)
        }
        else {
            smallKeyboardNode?.isHidden = true
            keyboardNode?.isHidden = false
            keyboardNode?.position = smallKeyboardNode!.position
            isMoved = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
//    @objc func tap(recognizer: UIGestureRecognizer) {
//            let viewLocation = recognizer.location(in: view)
//            let sceneLocation = convertPoint(fromView: viewLocation)
//    //        let moveToAction = SKAction.move(to: sceneLocation, duration: 1)
//    //        label.run(moveToAction)
//            let moveByAction = SKAction.moveBy(x: sceneLocation.x - label.position.x, y: sceneLocation.y - label.position.y, duration: 1)
//    //        label.run(moveByAction)
//
//            let moveByReversedAction = moveByAction.reversed()
//            let moveByActions = [moveByAction, moveByReversedAction]
//            let moveSequence = SKAction.sequence(moveByActions)
//            label.run(moveSequence)
//
//    //        let moveRepeatSequence = SKAction.repeat(moveSequence, count: 3)
//    //        label.run(moveRepeatSequence)
//
//    //        let moveRepeatForeverSequence = SKAction.repeatForever(moveSequence)
//    //        label.run(moveRepeatForeverSequence)
//        }
}
