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
    
    func basicAttack(target: Objective) -> Bool{
        if self.isExausted {
            print("\(self.name!) is exausted")
            return false
        }
        target.takeDamage()
        isExausted = true
        return true
    }
    
    func findAGoal() {
        guard let grid: Grid = GameManager.shared.grid else { fatalError("404 - Grid not founded in SprinterEnemy archive!") }
        guard let tileMatrix: [[Tile]] = grid.getAllNeightborsTilesInGroup(tile: self.tile) as? [[Tile]] else { fatalError("404 - TaleMatrix not founded in SprinterEnemy code!") }
        pathfinded = Pathfinding.shared.getNearestGoal(currentTile: self.tile, tilesMatrix: tileMatrix)
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
