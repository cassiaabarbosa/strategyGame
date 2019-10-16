//
//  HeavyEnemy.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class HeavyEnemy: Character {
    
    init(name: String, movement: Int, coord: (Int,Int), spriteAtlas: SKTextureAtlas, state: StateMachine, damage: Int, health: Int, attackRange: Int, breadcrumbs: [Tile]) {
        super.init(name: name, movement: movement, coord: coord, spriteAtlas: spriteAtlas, state: state, damage: damage, health: health, attackRange: attackRange, breadcrumbs: breadcrumbs)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func basicAttack() -> [Int] {
        return [self.damage]
    }
}
