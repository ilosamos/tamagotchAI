//
//  Structs.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 29.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

struct MovingDirection {
  var moving: Bool {
      return direction != .none
  }
  
  var direction: Direction  = .none
  
  init(_ dir: Direction) {
    self.direction = dir
  }
}

enum Direction {
  case left
  case right
  case up
  case down
  case none
}
