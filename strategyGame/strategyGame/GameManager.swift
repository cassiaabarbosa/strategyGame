//
//  GameManager.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    
    var enemies: [MachineControlled]
    var currentCharacter: Character?
    
    init(enemies: [MachineControlled], currentCharacter: Character?) {
        self.enemies = enemies
        self.currentCharacter = currentCharacter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveOnBoard(currentCharacter: Character, tile: Tile) {
        currentCharacter.position = tile.position
    }
}
