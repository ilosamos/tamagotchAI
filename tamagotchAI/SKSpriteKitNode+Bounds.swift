//
//  Player.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 30.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
  func getBounds(forSize screenSize: CGSize) -> PlayerBounds {
    return PlayerBounds(left: self.size.width / 2,
                        right: screenSize.width - self.size.width / 2,
                        top: self.size.height / 2,
                        bottom: screenSize.height - self.size.height / 2)
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
}

struct PlayerBounds {
  var left: CGFloat
  var right: CGFloat
  var top: CGFloat
  var bottom: CGFloat
}
