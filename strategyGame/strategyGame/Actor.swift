//
//  Character.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Actor: SKSpriteNode {
    
    var coord: (Int, Int)
    var sprite: SKTexture
    var state: State
    var movement: Int
    var damage: Int
    var health: Int
    var attackRange: Int
    var breadcrumbs: [Tile] = [Tile]()
    var wholeNumberValue: Float?
    
    init(name: String, movement: Int, coord: (Int, Int), sprite: SKTexture, state: State, damage: Int, health: Int, attackRange: Int) {
//        self.name = name
        self.movement = movement
        self.coord = (coord.0, coord.1)
        self.sprite = sprite
        self.state = state
        self.damage = damage
        self.health = health
        self.attackRange = attackRange
        super.init(texture: SKTexture(imageNamed: "OysterVolcano"), color: UIColor.clear, size: SKTexture(imageNamed: "OysterVolcano").size())
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func basicAttack() -> [Int] {
        return [damage, attackRange]
    }
    
    func specialAttack() {}
    
    func takeDamage(damage: Int) {
        self.health -= damage
        if (self.health <= 0) {
            //change state to dead
        }
    }
    
    func move() -> Int {
        return movement
    }
}
