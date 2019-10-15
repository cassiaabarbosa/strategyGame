//
//  Character.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode {
    
    var coord: (Int, Int)
    var spriteAtlas: SKTextureAtlas
    var state: StateMachine
    private let movement: Int
    var damage: Int
    var health: Int
    var attackRange: Int
    var breadcrumbs: [Tile]
    
    
    init(name: String, movement: Int, coord: (Int,Int), spriteAtlas: SKTextureAtlas, state: StateMachine, damage: Int, health: Int, attackRange: Int, breadcrumbs: [Tile]) {
        super.init()
        self.name = name
        self.movement = movement
        self.coord = coord
        self.spriteAtlas = spriteAtlas
        self.state = state
        self.damage = damage
        self.health = health
        self.attackRange = attackRange
        self.breadcrumbs = breadcrumbs
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func basicAttack() -> [Int] {
        return [damage, attackRange]
    }
    
    func specialAttack() {}
    
    func takeDamage(damage: Int){
        self.health -= damage
        if (self.health <= 0) {
            //change state to dead
        }
    }
    
    func move() -> Int {
        return movement
    }
}
