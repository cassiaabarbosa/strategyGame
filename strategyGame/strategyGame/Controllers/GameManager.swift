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
        case specialAttack
    }
    
    static let shared: GameManager = GameManager()
    var enemies: [MachineControlled]?
    var players: [Actor] = [Actor]()
    var mountains: [Mountain] = [Mountain]()
    var holes: [Hole] = [Hole]()
    var grid: Grid?
    var currentCharacter: Actor?
    var specialAttackButton: SpecialAttackButton?
    
    var mode: Mode {
        didSet {
            if currentCharacter == nil {
                return
            } else {
                if mode == .attack {
                    currentCharacter?.showAttackOptions()
                    print(specialAttackButton?.pressed ?? false)
                } else if mode == .move {
                    currentCharacter?.showMoveOptions()
                } else if mode == .specialAttack {
                    currentCharacter?.showSpecialAttackOptions()
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
        let meleePosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
        let melee = Melee(tile: grid.tiles[meleePosition])
        grid.addChild(melee)
        players.append(melee)
        
        let rangedPosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
        while (rangedPosition == meleePosition) {
            let rangedPosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
        }
        let ranged = Ranged(tile: grid.tiles[rangedPosition])
        grid.addChild(ranged)
        players.append(ranged)
    
        let trapperPosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
        while (trapperPosition == meleePosition || trapperPosition == rangedPosition) {
            let trapperPosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
        }
        let trapper = Trapper(tile: grid.tiles[trapperPosition])
        grid.addChild(trapper)
        players.append(trapper)
    }
    
    func setElementsOnGrid(gameScene: GameScene, grid: Grid) {
        self.grid = grid
        let mountainPosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
        let mountain = Mountain(tile: grid.tiles[mountainPosition])
        grid.addChild(mountain)
        mountains.append(mountain)
            
        let holePosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
            while (holePosition == mountainPosition) {
                let holePosition: Int = Int(arc4random_uniform(UInt32(Int(grid.tiles.count - 1))))
            }
            let hole = Hole(tile: grid.tiles[holePosition])
            grid.addChild(hole)
            holes.append(hole)
    }
    
    func endTurn() {
        
        // enemies move
        // ...
        
        beginTurn()
    }
    
    private func beginTurn() {
        for p in players {
            p.beginTurn()
        }
    }
    
    func touchTile(tile: Tile) {//função que mostra qual tile foi clicado
        func selectCharacter(character: Actor) {
            grid?.removeHighlights()
            currentCharacter = character
            if self.mode == .attack {
                currentCharacter?.showAttackOptions()
            } else if (self.mode == .specialAttack) {
                currentCharacter?.showSpecialAttackOptions()
            } else {
                currentCharacter?.showMoveOptions()
                self.mode = .move
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
        } else if tile.character == nil && self.mode == .move {
            currentCharacter.makeValidMove(tile: tile)
        } else if self.mode == .attack && tile.character != nil {
            currentCharacter.basicAttack(target: tile.character!)
        } else if self.mode == .specialAttack && tile.character == nil {
            currentCharacter.specialAttack(toTile: tile, gameManager: self, grid: grid)
        } else {
            grid?.removeHighlights()
            self.currentCharacter = nil
            return
        }
    }
}
