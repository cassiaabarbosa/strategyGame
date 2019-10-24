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
    var enemies: [Enemy] = [Enemy]()
    var players: [Actor] = [Actor]()
    var mountains: [Mountain] = [Mountain]()
    var holes: [Hole] = [Hole]()
    var grid: Grid! // has to be garanteed because of awake()
    var currentCharacter: Actor? {
        didSet {
            if oldValue == nil { return }
            oldValue!.shader = nil
        }
        willSet {
            if newValue == nil { return }
            if newValue!.isExausted {
                newValue!.shader = exaustedShader
            } else {
                newValue!.shader = highlightShader
            }
        }
    }
    var specialAttackButton: SpecialAttackButton?
    
    let exaustedShader = SKShader(fileNamed: "ExaustedShader.fsh")
    let highlightShader = SKShader(fileNamed: "HighlightShader.fsh")
    
    private var mode: Mode {
        didSet {
            switch (mode) {
            case .attack:
                currentCharacter?.showAttackOptions()
            case .move:
                currentCharacter?.showMoveOptions()
            case .specialAttack:
                currentCharacter?.showSpecialAttackOptions()
            default:
                grid?.removeHighlights()
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
        
        let sprinter = SprinterEmeny(tile: grid.randomEmptyTile())
        grid.addChild(sprinter)
        enemies.append(sprinter)
        
//        let heavy = HeavyEnemy(tile: grid.randomEmptyTile())
//        grid.addChild(heavy)
//        enemies.append(heavy)
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
        enemyTurn()
        beginTurn()
    }
    
    private func beginTurn() {
        for p in players {
            p.beginTurn()
        }
        if currentCharacter != nil {
            currentCharacter!.shader = self.highlightShader
            currentCharacter!.showMoveOptions()
        }
    }
    
    func touchTile(tile: Tile) {//função que mostra qual tile foi clicado
        func selectCharacter(character: Actor) {
            Button.unpressAll()
            grid?.removeHighlights()
            currentCharacter = character
            self.mode = .move
        }
        
        func deselectCharacter() {
            Button.unpressAll()
            grid?.removeHighlights()
            self.currentCharacter = nil
        }
        
        guard let currentCharacter = self.currentCharacter else {
            if let char = tile.character {
                selectCharacter(character: char)
            }
            return
        }
        
        if tile.character == currentCharacter {
            deselectCharacter()
        } else if tile.character == nil && self.mode == .move {
            if !currentCharacter.makeValidMove(tile: tile) {
                deselectCharacter()
            }
        } else if self.mode == .attack && tile.character != nil {
            if currentCharacter.basicAttack(target: tile.character!) {
                deselectCharacter()
            } else {
                selectCharacter(character: tile.character!)
            }
        } else if self.mode == .specialAttack && tile.character == nil {
            currentCharacter.specialAttack(toTile: tile)
            self.currentCharacter = nil
            grid?.removeHighlights()
        } else if tile.character != nil {
            selectCharacter(character: tile.character!)
        } else {
            deselectCharacter()
        }
    }
    
    func OnAttackButtonPress() {
        self.mode = .attack
    }
    
    func OnAttackButtonUnpress() {
        if self.currentCharacter == nil {
            self.mode = .clear
        } else {
            self.mode = .move
        }
    }
    
    func OnSpecialAttackButtonPress() {
        self.mode = .specialAttack
    }
    
    func OnSpecialAttackButtonUnpress() {
        if self.currentCharacter == nil {
            self.mode = .clear
        } else {
            self.mode = .move
        }
    }
    
    func OnEndTurnButtonPress() {
        endTurn()
    }
    
    func enemyTurn() {
        for enemie in 0...self.enemies.count - 1 {
            enemieMove(enemy: self.enemies[enemie])
        }
    }
    
    func enemieMove(enemy: Enemy) {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: ({_ in
            enemy.findAGoal()
            if !enemy.breadcrumbs.isEmpty {
                for tile in 0...enemy.breadcrumbs.count - 1 {
                    enemy.move(tile: enemy.breadcrumbs[tile])
                }
                enemy.breadcrumbs.removeAll()
            }
            
            if !enemy.isExausted {
                guard let objectiveTile: Tile = enemy.objective else { fatalError("404 - ObjectiveTile not founded in GameManger code!") }
                guard let player: Actor = objectiveTile.character else { fatalError("404 - Player not founded in GameManger code!") }
                _ = enemy.basicAttack(target: player)
            }
        }))
        
    }
}
