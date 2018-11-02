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
  var numberOfActions = 0
  var alpha: CGFloat = 0.0 // Learning rate
  var gamma: CGFloat = 0.0 // Discount Factor
  var epsilon: CGFloat = 0.0 // Exploration rate
  var Q: [[[CGFloat]]] = [] // State-Action Values
  var R: [[CGFloat]] = [] // Rewards
  var punishment: CGFloat = -1
  
  // Max Matrix Bounds
  var maxX: Int = 0 // Max x bound of Q matrix
  var maxY: Int = 0 // Max y bound of Q matrix
  
  var previousState = State(x: 0, y: 0)
  var previousAction: Direction = .none
  
  // Initialize Q values, rewards, states and environment bounds
  init(initState: State, dimX: Int, dimY: Int, numberOfActions: Int) {
    previousState = initState
    self.numberOfActions = numberOfActions
    maxX = dimX - 1
    maxY = dimY - 1
    Q = Array(repeating: Array(repeating: Array(repeating: 0.0, count: numberOfActions), count: dimY), count: dimX)
    R = Array(repeating: Array(repeating: punishment, count: dimY), count: dimX)
  }
  
  // Return next action (best or random)
  func takeStep(state: State) -> Direction {
    self.previousState = state
    let possibleActions = getPossibleActions(forState: state)
    var action: Direction = .none

    // Epsilon probability
    if(CGFloat.random(in: 0...1) < epsilon) {
      action = possibleActions.randomElement()!
    } else {
      // Else return best action based on Q values
      action = getBestAction(forState: state, possibleActions: possibleActions)
    }
  
    previousAction = action
    return action
  }
  
  // Update Q Value and return reward
  func updateQValue(forState state: State) -> CGFloat {
    let oldQ = Q[previousState.x][previousState.y][previousAction.rawValue] // Read q value of previous state
    let r = R[state.x][state.y] // Reward for current state
    
    // Here's the Q-Learning algorithm to update the Q-Value of the previous State/Action
    Q[previousState.x][previousState.y][previousAction.rawValue] = (1 - alpha) * oldQ + alpha * ( r + gamma * Q[state.x][state.y].max()! )
    return r
  }
  
  // Calculate best action from Q array
  func getBestAction(forState state: State, possibleActions: [Direction]) -> Direction {
    var bestActions: [Direction] = []
    var maxValue: CGFloat = -10000000
    
    // Calculate max value of possible actions
    for i in possibleActions {
      maxValue = max(maxValue, Q[state.x][state.y][i.rawValue])
    }
    
    // Get best action of possible actions
    for i in possibleActions {
      if Q[state.x][state.y][i.rawValue] == maxValue {
        bestActions.append(i)
      }
    }
    
    return bestActions.randomElement()!
  }
  
  // Define possible actions (player cant go outside of window)
  func getPossibleActions(forState state: State) -> [Direction] {
    // Define possible actions to avoid out of bounds
    var possibleActions: [Direction] = []
    possibleActions.append(Direction.none)
    if(state.x == 0) {
      possibleActions.append(Direction.right)
    } else if(state.x == maxX) {
      possibleActions.append(Direction.left)
    } else {
      possibleActions.append(Direction.right)
      possibleActions.append(Direction.left)
    }
    if(state.y == 0) {
      possibleActions.append(Direction.up)
    } else if(state.y == maxY) {
      possibleActions.append(Direction.down)
    } else {
      possibleActions.append(Direction.up)
      possibleActions.append(Direction.down)
    }
    return possibleActions
  }
  
  // Init Q array with random values
  private func randomizeQValues() {
    for x in 0...maxX {
      for y in 0...maxY {
        for z in 0...self.numberOfActions - 1 {
          Q[x][y][z] = CGFloat.random(in: 0...1)
        }
      }
    }
  }
  
  // For printing q
  func printQ(){
    for x in 0...maxX {
      for y in 0...maxY {
        print("Q[\(x)][\(y)][left] = \(Q[x][y][Direction.left.rawValue])")
        print("Q[\(x)][\(y)][right] = \(Q[x][y][Direction.right.rawValue])")
        print("Q[\(x)][\(y)][up] = \(Q[x][y][Direction.up.rawValue])")
        print("Q[\(x)][\(y)][down] = \(Q[x][y][Direction.down.rawValue])")
        print("Q[\(x)][\(y)][none] = \(Q[x][y][Direction.none.rawValue])")
      }
    }
  }
}
