//
//  QLearning.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 31.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import Foundation
import CoreGraphics

class QLearning {
  var alpha = 0.0
  var gamma = 0.0
  var epsilon = 0.0
  var Q: [[CGFloat]] = []
  
  init(dimX: Int, dimY: Int) {
    Q = Array(repeating: Array(repeating: 0.0, count: dimY), count: dimX)
  }
}
