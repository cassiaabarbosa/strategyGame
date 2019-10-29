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
    var scene: GameScene!
    var enemies: [Enemy] = [Enemy]() {
        willSet {
            if enemies.count < newValue.count {
                grid.addChild(newValue.last!)
            }
        }
    }
    var players: [Actor] = [Actor]() {
        willSet {
            if players.count < newValue.count {
                grid.addChild(newValue.last!)
            }
        }
    }
    var mountains: [Mountain] = [Mountain]() {
        willSet {
            if mountains.count < newValue.count {
                grid.addChild(newValue.last!)
            }
        }
    }
    
    var holes: [Hole] = [Hole]() {
        willSet {
            if holes.count < newValue.count {
                grid.addChild(newValue.last!)
            }
        }
    }
    var objectives: [Objective] = [Objective]() {
        willSet {
            if objectives.count < newValue.count {
                grid.addChild(newValue.last!)
            }
            if newValue.isEmpty {
                print("GAME OVER")
            }
        }
    }
    var grid: Grid! // has to be guaranteed because of awake()
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
            default: // .clear
                grid?.removeHighlights()
            }
        }
    }
    
    private init() {
        mode = .clear
    }
    
    func awake(grid: Grid, scene: GameScene) {
        self.scene = scene
        self.grid = grid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func endTurn() {
        Button.unpressAll()
        grid?.removeHighlights()
        self.currentCharacter = nil
        enemyTurn()
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
    
    func touchTile(tile: Tile) { //função que mostra qual tile foi clicado
        func selectCharacter(character: Actor) {
            Button.unpressAll()
            Button.showAll()
            grid?.removeHighlights()
            currentCharacter = character
            self.mode = .move
        }
        
        func deselectCharacter() {
            Button.unpressAll()
            Button.hideAttackButtons()
            grid?.removeHighlights()
            self.currentCharacter = nil
        }
        
        guard let currentCharacter = self.currentCharacter else {
            if let char = tile.character {
                selectCharacter(character: char)
            }
            return
        }
        // verificar se o tile atacado está nos ableTiles
        // se não, desselecionar personagem
        // switch case (.mode)
        // se .attack: ataca o tile e o tile passa o ataque para o que for que estiver em cima dele
        // se nao tiver nada em cima do tile, o personagem não ataca/ não fica exausto
        if tile.character == currentCharacter {
            deselectCharacter()
        } else if tile.character == nil && self.mode == .move {
            if currentCharacter.makeValidMove(tile: tile) {
                if let trap = tile.prop as? Trap {
                    trap.activateTrap(character: currentCharacter)
                }
            } else {
                deselectCharacter()
            }
        } else if self.mode == .attack && tile.character != nil {
            if currentCharacter.basicAttack(target: tile.character!) {
                deselectCharacter()
            } else {
                selectCharacter(character: tile.character!) // nao funciona para monstros
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
        for enemy in enemies {
            enemyMove(enemy: enemy)
        }
    }
    
    func enemyMove(enemy: Enemy) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: ({_ in
            enemy.findAGoal()
            if !enemy.breadcrumbs.isEmpty {
                for tile in 0...enemy.breadcrumbs.count - 1 {
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
                if let _ = objectiveTile.prop as? Objective {
                    guard let objective: Objective = objectiveTile.prop as? Objective else { fatalError("404 - Player not founded in GameManger code!") }
                    _ = enemy.basicAttack(target: objective)
                }
            }
            self.beginTurn()
        }))
        
    }
}
