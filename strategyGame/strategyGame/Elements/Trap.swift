//
//  Trap.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 17/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Trap: Element {
    
    init(tile: Tile) {
        super.init(name: "Trap", sprite: SKTexture(imageNamed: "trap"), tile: tile, qntdTurnStunned: 1)
        self.scale(to: CGSize(width: 55, height: 55))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activateTrap(character: Actor) {
        character.stun(turns: 2)
        self.removeFromParent()
        self.tile.prop = nil
    }
}
