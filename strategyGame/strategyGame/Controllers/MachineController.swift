//
//  MachineControlled.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class MachineController {
    
    static let shared: MachineController = MachineController()
    
    func enemyMove(enemies: [Enemy]) {
        for enemy in enemies {
            print(enemy.name)
            enemy.findAGoal()
            if !enemy.breadcrumbs.isEmpty {
                for tile in 0 ..< enemy.breadcrumbs.count {
                    enemy.move(tile: enemy.breadcrumbs[tile])
                }
                enemy.breadcrumbs.removeAll()
            }
            
            if !enemy.isExausted {
                guard let objectiveTile: Tile = enemy.objective else { fatalError("404 - ObjectiveTile not founded in GameManger code!") }
                if objectiveTile.character != nil {
                    guard let player: Actor = objectiveTile.character else { fatalError("404 - Player not founded in GameManger code!") }
                    _ = enemy.basicAttack(target: player)
                }
                if let _: Objective = objectiveTile.prop as? Objective {
                    guard let objective: Objective = objectiveTile.prop as? Objective else { fatalError("404 - Player not founded in GameManger code!") }
                    _ = enemy.basicAttack(target: objective)
                }
            }
            print("ok")
        }
        GameManager.shared.beginTurn()
    }
}
