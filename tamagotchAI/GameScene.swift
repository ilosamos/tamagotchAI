//
//  GameScene.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 29.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import SpriteKit

class GameScene: Environment {
  let player = Player(imageNamed: "player") // The agent
  
  // Be careful that you dont get out of bounds with x and y values, depends on your iOS device
  let initState = State(x: 0, y: 0) // The initial State
  let finalState = State(x: 12, y: 6) // The final or winning state
  
  var ql: QLearning!
  let numberOfActions = 5 // Number of possible actions (left, right, up, down, none), dont change this
  
  var countWins: Int = 0 // Counting episodes
  var countRewards: CGFloat = 0 // Counting sum of rewards
  
  var stepSpeed: TimeInterval = 0.01 // Speed of agent running through environment
  
  override func didMove(to view: SKView) {
    backgroundColor = SKColor.white
    
    // Do some environment initialization and graphical stuff (Environment.swift)
    initStates(tileSize: player.size.width)
    drawMatrix(size: tileSize)
    drawTargetField(finalState)
    drawInitField(initState)
    
    // Set Player to starting point
    player.initState(initState, statesX: tilesX, statesY: tilesY)
    addChild(player)
    
    ql = QLearning(initState: initState, dimX: tilesX, dimY: tilesY, numberOfActions: numberOfActions)
    
    // Init constants
    /*** THIS IS WHERE YOU CAN TRY DIFFERENT VALUES ***/
    ql.epsilon = 0.2 // Exploring rate
    ql.alpha = 0.5 // Learning rate
    ql.gamma = 0.9 // Discount factor
    
    ql.R[finalState.x][finalState.y] = 100 // Reward for final state
    ql.punishment = -1 // Punishment for any other state than final state
    // You could also add some negativ rewards to give the player some "obstacles"
    /*ql.R[10][6] = -50
    ql.R[10][5] = -50
    ql.R[10][4] = -50
    ql.R[10][3] = -50
    ql.R[10][2] = -50
    ql.R[10][1] = -50*/
    /*************************************************/
    
    // Start learning
    let action = SKAction.sequence([SKAction.run(nextStep), SKAction.wait(forDuration: stepSpeed)])
    run(SKAction.repeatForever(action))
  }
  
  // Take action and update q value after action
  func nextStep() {
    //print("DO STEP")
    //print("Take Action: \(action)")
    //print("Q-Values: \(ql.Q[player.state.x][player.state.y])")
    //print("Rewards: \(ql.R[player.state.x][player.state.y])")
    //print("-------------------------------------")
    
    player.takeStep(ql.takeStep(state: State(x: player.state.x, y: player.state.y)))
    countRewards += ql.updateQValue(forState: player.state)
    
    // If final state count up and print infos
    if player.isInState(finalState) {
      countWins += 1
      player.initState(initState, statesX: tilesX, statesY: tilesY)
      print("ROUND ENDED, rewards: \(countRewards), now running round \(countWins)")
      if(countWins % 10 == 0) {
        ql.printQ() // To show the q values in the output
      }
    }
  }
  
  override func update(_ currentTime: TimeInterval) {
    super.update(currentTime)
    
    // Check if player hit the wall, not necessary here
    player.checkBounds(forSize: size)
  }
  
  /* Following code is not needed for q learning
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
        player.takeStep(.right)
      } else if loc.x < 0.2 * size.width  {
        player.takeStep(.left)
      } else if loc.y <= 0.5 * size.height {
        player.takeStep(.up)
      } else if loc.y > 0.5 * size.height {
        player.takeStep(.down)
      }
    }
  } */
}
