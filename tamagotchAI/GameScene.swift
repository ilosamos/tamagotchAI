//
//  GameScene.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 29.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  let player = SKSpriteNode(imageNamed: "player")
  let movingSpeed: CGFloat = 3.0
  
  var movingDir = MovingDirection(.none)
  
  override func didMove(to view: SKView) {
    backgroundColor = SKColor.white
    player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
    addChild(player)
    spawnGoodie()
    spawnGoodie()
    spawnGoodie()
  }
  
  override func update(_ currentTime: TimeInterval) {
    super.update(currentTime)
    
    // Move Player
    switch movingDir.direction {
      case .left: player.position.x -= movingSpeed
      case .right: player.position.x += movingSpeed
      case .up: player.position.y += movingSpeed
      case .down: player.position.y -= movingSpeed
      case .none: break
    }
    // Check if player hit the wall
    player.checkBounds(forSize: size)
  }

  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  func spawnGoodie() {
    // Create sprite
    let goodie = SKSpriteNode(imageNamed: "goodie")
    
    // Determine where to spawn the monster along the Y axis
    let actualY = random(min: goodie.size.height / 2, max: size.height - goodie.size.height / 2)
    let actualX = random(min: goodie.size.width / 2, max: size.width - goodie.size.width / 2)
    
    // and along a random position along the Y axis as calculated above
    goodie.position = CGPoint(x: actualX, y: actualY)
    
    // Add the monster to the scene
    addChild(goodie)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let loc = touch.location(in: view)
      if loc.x > 0.8 * size.width {
        movingDir.direction = .right
      } else if loc.x < 0.2 * size.width  {
        movingDir.direction = .left
      } else if loc.y <= 0.5 * size.height {
        movingDir.direction = .up
      } else if loc.y > 0.5 * size.height {
        movingDir.direction = .down
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    movingDir.direction = .none
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    movingDir.direction = .none
  }
}
