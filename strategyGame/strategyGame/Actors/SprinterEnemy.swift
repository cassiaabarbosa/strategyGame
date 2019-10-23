//
//  SprinterEnemy.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class SprinterEmeny: Actor, MachineControlled {
    var pathfinded: [Tile] = [Tile]()
    var objective: Tile?
    var canAttack: Bool = false
    
    init(tile: Tile) {
        super.init(name: "Sprinter", movement: 4, damage: 2, health: 4, attackRange: 1, sprite: SKTexture(imageNamed: "00_clam"), tile: tile)
        let animation = SKAction.animate(with: AnimationHandler.shared.trapperFrames, timePerFrame: 1/TimeInterval(5))
//        self.run(SKAction.repeatForever(animation))
        findAnGoal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func findAnGoal() {
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
        canAttack = pathfinded.count == 0 ? true : false
        print(canAttack)
    }
}
