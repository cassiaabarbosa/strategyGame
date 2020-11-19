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
    
    func enemyMove(enemies: [Enemy], completion: @escaping () -> Void) {
        func moveEnemy(_ enemy: Enemy, completion: @escaping () -> Void) {
            enemy.findAGoal()
            if enemy.stunned > 0 {
                enemy.stunned -= 1
                completion()
                return
            }
            if !enemy.breadcrumbs.isEmpty {
                for tile in 0 ..< enemy.breadcrumbs.count {
                    enemy.walk(tile: enemy.breadcrumbs[tile])
                }
                enemy.breadcrumbs.removeAll()
            }
            
            if !enemy.isExausted {
                guard let objectiveTile = enemy.objective else { fatalError("MachineController::enemyMove(): objectiveTile not found!") }
                if objectiveTile.character != nil {
                    guard let player: Actor = objectiveTile.character else { fatalError("MachineController::enemyMove(): player not found!") }
                    enemy.basicAttack(tile: player.tile, completion: {
                        completion()
                    })
                } else if let _ = objectiveTile.prop as? Objective {
                    guard let objective: Objective = objectiveTile.prop as? Objective else { fatalError("MachineController::enemyMove(): objective not found!") }
                    enemy.basicAttack(tile: objective.tile, completion: {
                        completion()
                    })
                } else {
                    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
                        completion()
                    }
                }
            } else {
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
                    completion()
                }
            }
        }
        
        func enemyTurnRecursively(enemies: [Enemy], index: Int) {
            if index == enemies.count {
                completion()
                return
            }
            moveEnemy(enemies[index]) {
                enemyTurnRecursively(enemies: enemies, index: index + 1)
            }
        }
        
        if enemies.count == 0 {
            fatalError("MachineController::enemyMove(): enemy array found empty!")
        }
        
        enemyTurnRecursively(enemies: enemies, index: 0)
    }
}
