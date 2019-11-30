//
//  Character.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: Actor {
    
    var pathfinded: [Tile] = [Tile]()
    var objective: Tile?
    var canAttack: Bool = false
    
    override func basicAttack(tile: Tile, completion: @escaping () -> Void) {
        GameManager.shared.scene.canoSound.run(SKAction.play())
        tile.character?.takeDamage(damage: self.damage)
        if let objective = tile.prop as? Objective {
            objective.takeDamage()
        }
        guard let grid = GameManager.shared.grid else { return }
        switch grid.getDirection(from: self.tile, to: tile) {
        case 0:
            tile.push(direction: 0, completion: {
                completion()
            })
        case 1:
            tile.push(direction: 1, completion: {
                completion()
            })
        case 2:
            tile.push(direction: 2, completion: {
                completion()
            })
        case 3:
            tile.push(direction: 3, completion: {
                completion()
            })
        default:
            print("Enemy::basicAttack(): switch exausted!")
            return
        }
        isExausted = true
    }
    
    // Comment(Alex) - findAGoal() also calls setWay
    // make everything only one method and rename findAGoal()
    func findAGoal() {
        let grid: Grid = GameManager.shared.grid
        guard let tileMatrix: [[Tile]] = grid.getAllNeightborsTilesInGroup(tile: self.tile) as? [[Tile]] else {fatalError("enemy tileMatrix nil")}
        pathfinded = Pathfinding.shared.getNearestGoal(currentTile: self.tile, tilesMatrix: tileMatrix)
        var aux = [Int]()
        for tile in pathfinded {
            aux.append(tile.id)
        }
        setWay()
    }
    
    func setWay() {
        objective = pathfinded.removeLast()
        if pathfinded.count != 0 {
            if pathfinded.count >= self.movement {
                for _ in 0...self.movement - 1 {
                    self.breadcrumbs.append(pathfinded.removeFirst())
                }
            } else {
                for _ in 0...pathfinded.count - 1 {
                    self.breadcrumbs.append(pathfinded.removeFirst())
                }
            }
        }
        
        self.isExausted = pathfinded.count == 0 ? false : true
    }
}
