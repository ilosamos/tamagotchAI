//
//  ViewController.swift
//  tamagotchAI
//
//  Created by Daniel Berger on 29.10.18.
//  Copyright © 2018 Daniel Berger. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let scene = GameScene(size: view.bounds.size)
    let skView = view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .resizeFill
    skView.presentScene(scene)  }
}

