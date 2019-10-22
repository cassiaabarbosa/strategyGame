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
    var grid: Grid! // has to be garanteed because of awake()
    var currentCharacter: Actor?
    var specialAttackButton: SpecialAttackButton?
    
    var mode: Mode {
        didSet {
            if currentCharacter == nil {
                return
            } else {
                if mode == .attack {
                    currentCharacter?.showAttackOptions()
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
    
    func awake(grid: Grid) {
        self.grid = grid
        setActorsOnGrid()
        setElementsOnGrid()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setActorsOnGrid() {
        let melee = Melee(tile: grid.randomEmptyTile())
        grid.addChild(melee)
        players.append(melee)
        
        let ranged = Ranged(tile: grid.randomEmptyTile())
        grid.addChild(ranged)
        players.append(ranged)
    
        let trapper = Trapper(tile: grid.randomEmptyTile())
        grid.addChild(trapper)
        players.append(trapper)
    }
    
    private func setElementsOnGrid() {
        let mountain = Mountain(tile: grid!.randomEmptyTile())
        grid.addChild(mountain)
        mountains.append(mountain)
        
        let hole = Hole(tile: grid!.randomEmptyTile())
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
