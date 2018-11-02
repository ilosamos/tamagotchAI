//
//  Player.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 30.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
  var state: State = State(x: 0, y: 0)
  var maxState: State = State(x:0, y: 0)
  
  init(imageNamed: String) {
    let texture = SKTexture(imageNamed: imageNamed)
    super.init(texture: texture, color: .black, size: texture.size())
  }
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func getBounds(forSize screenSize: CGSize) -> PlayerBounds {
    return PlayerBounds(left: self.size.width / 2,
                        right: screenSize.width - self.size.width / 2,
                        top: self.size.height / 2,
                        bottom: screenSize.height - self.size.height / 2)
  }
  
  func initState(_ initState: State, statesX: Int, statesY: Int) {
    position.x = CGFloat(initState.x + 1) * size.width - (size.width / 2)
    position.y = CGFloat(initState.y + 1) * size.height - (size.height / 2)
    state = initState
    maxState = State(x: statesX - 1, y: statesY - 1)
  }
  
  func updateState() {
    let x = min(Int(position.x / size.width), maxState.x)
    let y = min(Int(position.y / size.height), maxState.y)
    state = State(x: x, y: y)
  }
  
  // Check Collission with wall
  func checkBounds(forSize screenSize: CGSize) {
    let bounds = getBounds(forSize: screenSize)
    
    if position.x <= bounds.left {
      position.x = bounds.left
    } else if position.x >= bounds.right {
      position.x = bounds.right
    }
    if position.y >= bounds.bottom {
      position.y = bounds.bottom
    } else if position.y <= bounds.top {
      position.y = bounds.top
    }
  }
  
  // Take step to any direction
  func takeStep(_ direction: Direction) {
    switch direction {
      case .left: position.x -= size.width
      case .right: position.x = min((position.x + size.width), (CGFloat(maxState.x) + 1) * size.width - size.width / 2)
      case .up: position.y = min((position.y + size.height), (CGFloat(maxState.y) + 1) * size.height - size.height / 2)
      case .down: position.y -= size.height
      case .none: break
    }
    updateState()
  }
  
  // Check if player is currently in given state
  func isInState(_ state: State) -> Bool {
    return self.state.x == state.x && self.state.y == state.y
  }
}
