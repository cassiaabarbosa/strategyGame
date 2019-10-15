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
    
    let movement: Int
    var coord: (Int, Int)
    var spriteAtlas: SKTextureAtlas
//    var state: StateMachine
    var damage: Int
    var health: Int
    var attackRange: Int
//    var breadcrumbs: [Tile]
    
    
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
    
    func basicAttack(){
    }
    
    func specialAttack(){
        
    }
    
    func takeDamage(){
        
    }
    
    func move([Tile]){
        
    }
}
