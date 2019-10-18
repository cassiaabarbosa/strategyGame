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
    
    enum Mode {
        case clear
        case move
        case attack
    }
    
    static let shared: GameManager = GameManager()
    var enemies: [MachineControlled]?
    var players: [Actor] = [Actor]()
    var grid: Grid?
    var currentCharacter: Actor?
    
    var mode: Mode {
        didSet {
            if currentCharacter == nil {
                return
            } else {
                if mode == .attack {
                    grid?.showAttackOptions(character: self.currentCharacter!)
                } else if mode == .move {
                    grid?.showMoveOptions(character: self.currentCharacter!)
                } else {
                    grid?.removeHighlights()
                }
            }
        }
    }
    
    private init() {
        mode = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setActorsOnGrid(gameScene: GameScene, grid: Grid) {
        self.grid = grid
        let melee = Melee(tile: grid.tiles[21])
        grid.addChild(melee)
        players.append(melee)
        let ranged = Ranged(tile: grid.tiles[15])
        grid.addChild(ranged)
        players.append(ranged)
        let trapper = Trapper(tile: grid.tiles[34])
        grid.addChild(trapper)
        players.append(trapper)
    }

    func touchTile(tile: Tile) {
        func selectCharacter(character: Actor) {
            grid?.removeHighlights()
            currentCharacter = character
            if self.mode == .attack {
                grid?.showAttackOptions(character: currentCharacter!)
            } else {
                grid?.showMoveOptions(character: currentCharacter!)
            }
        }
        
        guard let currentCharacter = self.currentCharacter else {
            if let char = tile.character {
                selectCharacter(character: char)
            }
            return
        }
        
        if tile.character == currentCharacter {
            return
        } else if tile.character == nil && self.mode != .attack {
            currentCharacter.makeValidMove(tile: tile)
        } else if self.mode == .attack && tile.character != nil {
            currentCharacter.basicAttack(target: tile.character!)
        } else {
            grid?.removeHighlights()
            self.currentCharacter = nil
            return
        }
    }
}
