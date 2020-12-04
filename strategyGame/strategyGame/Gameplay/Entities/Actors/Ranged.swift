//
//  Ranged.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Ranged: Actor {
    
    init(tile: Tile) {
    super.init(name: "Ranged", movement: 3, damage: 1, health: 3, attackRange: 3, sprite: SKTexture(imageNamed: "00_ranged"), tile: tile)
        let animation = SKAction.animate(with: AnimationHandler.shared.rangedFrames, timePerFrame: 1/TimeInterval(6))
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func showAttackOptions() {
        if self.isExausted { return }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: max(grid.gridAspect.0, grid.gridAspect.1))
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.attackHighlightShader
        }
    }
    
    override func basicAttack(tile: Tile, completion: @escaping () -> Void) {
        guard GameManager.shared.grid != nil else { return }
        GameManager.shared.scene.cameraSound.run(SKAction.play())
        tile.character?.takeDamage(damage: self.damage)
        isExausted = true
        completion()
        return
    }
    
    override func showSpecialAttackOptions() {
        if self.isExausted { return }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: max(grid.gridAspect.0, grid.gridAspect.1))
        for t in tiles {
            if grid.getTilesAround(tile: self.tile).contains(t) { continue }
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.specialAttackHighlightShader
        }
    }
    
    override func specialAttack(tile: Tile, completion: @escaping () -> Void) {
        guard let grid = GameManager.shared.grid else { return }
        // damage target
        if let target = tile.character {
            target.takeDamage(damage: self.damage)
        }
        // push adjacent tiles
        if let upTile = grid.getUpTile(tile: tile) {
            upTile.push(direction: 0, completion: {
                completion()
            })
        }
        if let downTile = grid.getDownTile(tile: tile) {
            downTile.push(direction: 1, completion: {
                completion()
            })
        }
        if let leftTile = grid.getLeftTile(tile: tile) {
            leftTile.push(direction: 2, completion: {
                completion()
            })
        }
        if let rightTile = grid.getRightTile(tile: tile) {
            rightTile.push(direction: 3, completion: {
                completion()
            })
        }
        grid.removeHighlights()
        isExausted = true
    }
    
}
