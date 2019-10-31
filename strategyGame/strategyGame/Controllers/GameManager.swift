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
    var enemies: [Enemy] = [Enemy]()
    var players: [Actor] = [Actor]()
    var mountains: [Mountain] = [Mountain]()
    var holes: [Hole] = [Hole]()
    var objectives: [Objective] = [Objective]()
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
    
    func addSelf(_ entity: Entity) {
        if let actor = entity as? Actor {
            if let enemy = entity as? Enemy {
                enemies.append(enemy)
            } else {
                players.append(actor)
            }
        } else {
            if let mountain = entity as? Mountain {
                mountains.append(mountain)
            } else if let hole = entity as? Hole {
                holes.append(hole)
            } else if let objective = entity as? Objective {
                objectives.append(objective)
            }
        }
        grid.addChild(entity)
    }
    
    func removeSelf(_ entity: Entity) {
        if let actor = entity as? Actor {
            if let enemy = entity as? Enemy {
                enemies.remove(at: enemies.firstIndex(of: enemy)!)
            } else {
                players.remove(at: players.firstIndex(of: actor)!)
            }
            actor.tile.character = nil
        } else {
            if let mountain = entity as? Mountain {
                mountains.remove(at: mountains.firstIndex(of: mountain)!)
            } else if let hole = entity as? Hole {
                holes.remove(at: holes.firstIndex(of: hole)!)
            } else if let objective = entity as? Objective {
               objectives.remove(at: objectives.firstIndex(of: objective)!)
            }
            entity.tile.prop = nil
        }
        entity.removeFromParent()
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
    
    func touchTile(tile: Tile) {
        func selectCharacter(character: Actor) {
            Button.unpressAll()
            Button.showAll()
            grid?.removeHighlights()
            currentCharacter = character
            if character.movesLeft == 0 {
                self.mode = .attack
            } else {
                self.mode = .move
            }
        }
        
        func deselectCharacter() {
            Button.unpressAll()
            Button.hideAttackButtons()
            mode = .clear
            self.currentCharacter = nil
        }
        
        // se .clear, selecionar tile...
        if mode == .clear {
            if tile.character != nil {
                if tile.character is Enemy {
                    return
                } else {
                    // se tile tiver personagem -> selectCharacter, .move, return
                    if tile.character is Enemy { return }
                    selectCharacter(character: tile.character!)
                }
            }
        }
        // .move, .attack e .specialAttack dependem de grid.ableTiles, logo...
        else if grid.ableTiles.contains(tile) {
            if mode == .move {
                self.currentCharacter?.walk(tile: tile)
                mode = .attack
            } else if mode == .attack {
                self.currentCharacter?.basicAttack(tile: tile)
                deselectCharacter()
            } else if mode == .specialAttack {
                self.currentCharacter?.specialAttack(tile: tile)
                deselectCharacter()
            }
        } else {
            if let character = tile.character {
                if tile.character is Enemy { return }
                selectCharacter(character: character)
            } else {
                deselectCharacter()
            }
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
                    enemy.walk(tile: enemy.breadcrumbs[tile])
                }
                enemy.breadcrumbs.removeAll()
            }
            
            if !enemy.isExausted {
                guard let objectiveTile: Tile = enemy.objective else { fatalError("404 - ObjectiveTile not founded in GameManger code!") }
                if objectiveTile.character != nil {
                    guard let player: Actor = objectiveTile.character else { fatalError("404 - Player not founded in GameManger code!") }
                    _ = enemy.basicAttack(tile: player.tile)
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
