//
//  GameScene.swift
//  Pong
//
//  Created by Zuri Wong on 8/25/18.
//  Copyright © 2018 Zuri Wong. All rights reserved.
//

import SpriteKit
import GameplayKit

var currentGameType = gameType.medium

class GameScene: SKScene {
    var viewController: GameViewController!
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var bottomLbl = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
//        let playAgainBtn = SKSpriteNode()
//        playAgainBtn.name = "playAgainButton"
//        playAgainBtn.size = CGSize(width: 50, height: 20)
//        playAgainBtn.position = CGPoint(x: (self.frame.width/2) - 55, y: -(self.frame.height/2) + 30)
//        self.addChild(playAgainBtn)
//
//        let buttonText = SKLabelNode(text: "Play Again")
//        buttonText.fontColor = UIColor.init(displayP3Red: 247, green: 255, blue: 0, alpha: 50)
//        buttonText.position = CGPoint(x: 0, y: 0)
//        buttonText.fontSize = 20
//        buttonText.fontName = "LLPixel"
//        buttonText.verticalAlignmentMode = SKLabelVerticalAlignmentMode(rawValue: 1)!
//        buttonText.name = "playAgainButton"
//        buttonText.zPosition = 2
//        playAgainBtn.addChild(buttonText)
        
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLbl = self.childNode(withName: "bottomLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = -(self.frame.height / 2) + 50

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    
    func startGame(){
        score = [0, 0]
        topLbl.text = "\(score[1])"
        bottomLbl.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10 , dy: 10))
    }
    
    func addScore(playerWhoWon: SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10 , dy: 10))
            
        }else if playerWhoWon == enemy{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        
        topLbl.text = "\(score[1])"
        bottomLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            if currentGameType == .player2{
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }else if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
//            enumerateChildNodes(withName: "//*", using: {(node, stop) in
//                if node.name == "playAgainBtn"{
//                    if node.contains(touch.location(in: self)){
//                        let menuVC = self.view..instantiateViewController(withIdentifier: "MenuVC") as! UIViewController
//                        self.navigationController?.pushViewController(menuVC, animated: true)
//                    }
//                }
//
//            })
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if currentGameType == .player2{
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }else if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentGameType{
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .player2:
            
            break
        }
        
        if ball.position.y <= main.position.y - 30{
            addScore(playerWhoWon: enemy)
        }else if ball.position.y >= enemy.position.y + 30{
            addScore(playerWhoWon: main)
            
        }
    }
    
//    func repeatGame(){
//        performSegueWithIdentifier("MenuVC", sender: nil)
//    }
}
