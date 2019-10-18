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
    
    var coord: Coord
    var sprite: SKTexture
    var state: State
    var movement: Int
    var damage: Int
    var health: Int
    var attackRange: Int
    var breadcrumbs: [Tile] = [Tile]()
    var tile: Tile {
        return breadcrumbs[0]
    }
    var wholeNumberValue: Float?
    var canMove: Bool = true
    
    init(name: String, movement: Int, coord: (Int, Int), sprite: SKTexture, state: State, damage: Int, health: Int, attackRange: Int) {
        self.movement = movement
        self.coord = Coord(coord.1, coord.0)
        self.sprite = sprite
        self.state = state
        self.damage = damage
        self.health = health
        self.attackRange = attackRange
        super.init(texture: sprite, color: UIColor.clear, size: sprite.size())
        self.name = name
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
