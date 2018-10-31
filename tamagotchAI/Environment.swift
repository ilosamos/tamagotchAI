//
//  SKScene+Matrix.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 30.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import SpriteKit

class Environment: SKScene {
  var tileSize: CGFloat = 0.0
  var tilesX: Int = 0
  var tilesY: Int = 0
  
  // Set TileSize and Number of Tiles
  func initStates(tileSize: CGFloat) {
    self.tileSize = tileSize
    tilesX = Int(size.width / tileSize)
    tilesY = Int(size.height / tileSize)
  }
  
  // Draw matrix with given tile size
  func drawMatrix(size: CGFloat) {
    var i = 1
    while true {
      let tileX = CGFloat(i) * size
      guard tileX <= self.size.width else {
        break
      }
      let line_path:CGMutablePath = CGMutablePath()
      line_path.move(to: CGPoint(x: tileX, y: 0))
      line_path.addLine(to: CGPoint(x: tileX, y: self.size.height))
      let shape = SKShapeNode()
      shape.path = line_path
      shape.strokeColor = UIColor.black
      shape.lineWidth = 1
      addChild(shape)
      i += 1
    }
    i = 1
    while true {
      let tileY = CGFloat(i) * size
      guard tileY <= self.size.width else {
        break
      }
      let line_path:CGMutablePath = CGMutablePath()
      line_path.move(to: CGPoint(x: 0, y: tileY))
      line_path.addLine(to: CGPoint(x: self.size.width, y: tileY))
      let shape = SKShapeNode()
      shape.path = line_path
      shape.strokeColor = UIColor.black
      shape.lineWidth = 1
      addChild(shape)
      i += 1
    }
  }
  
  // Draw Matrix with given width tile number
  func drawMatrix(_ xtiles: Int) {
    let tileWidth = size.width / CGFloat(xtiles)
    let ytiles = Int(round(size.height / tileWidth))
    
    // Draw X Lines
    for i in 1...xtiles {
      let tileX = CGFloat(i) * tileWidth
      let line_path:CGMutablePath = CGMutablePath()
      line_path.move(to: CGPoint(x: tileX, y: 0))
      line_path.addLine(to: CGPoint(x: tileX, y: size.height))
      let shape = SKShapeNode()
      shape.path = line_path
      shape.strokeColor = UIColor.black
      shape.lineWidth = 1
      addChild(shape)
    }
    
    // Draw Y Lines
    for i in 1...ytiles {
      let tileY = CGFloat(i) * tileWidth
      let line_path:CGMutablePath = CGMutablePath()
      line_path.move(to: CGPoint(x: 0, y: tileY))
      line_path.addLine(to: CGPoint(x: size.width, y: tileY))
      let shape = SKShapeNode()
      shape.path = line_path
      shape.strokeColor = UIColor.black
      shape.lineWidth = 1
      addChild(shape)
    }
  }
}
