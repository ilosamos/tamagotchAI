//
//  Structs.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 29.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import CoreGraphics

// These are the different actions the player can take
enum Direction: Int {
  case left = 0
  case right = 1
  case up = 2
  case down = 3
  case none = 4
}

struct PlayerBounds {
  var left: CGFloat
  var right: CGFloat
  var top: CGFloat
  var bottom: CGFloat
}

struct State {
  var x: Int = 0
  var y: Int = 0
}

