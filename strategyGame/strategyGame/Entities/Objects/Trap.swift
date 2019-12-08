//
//  Trap.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 17/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Trap: Entity, Pushable {
    
    init(tile: Tile) {
        super.init(name: "Trap", sprite: SKTexture(imageNamed: "trap"), tile: tile)
        self.scale(to: CGSize(width: 55, height: 55))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func move(tile: Tile) {
        self.tile.prop = nil
        self.position = tile.position
        self.tile = tile
        tile.prop = self
    }
    
    func push(to target: Tile, from sender: Tile, completion: @escaping () -> Void) {
        if target.isWalkable {
            self.move(tile: target)
            completion()
        } else if target.character != nil {
            self.activateTrap(character: target.character!)
            completion()
        } else if target.prop is Hole {
            GameManager.shared.scene.cairBuracoSound.run(SKAction.play())
            GameManager.shared.removeSelf(self)
            completion()
        }
    }
    
    func activateTrap(character: Actor) {
        GameManager.shared.scene.quackSound.run(SKAction.play())
        GameManager.shared.removeSelf(self)
        character.stun(turns: 2)
    }
}
