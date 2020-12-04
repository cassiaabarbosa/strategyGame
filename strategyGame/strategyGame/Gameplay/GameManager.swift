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
    
    static let shared = GameManager()
    var animating: Bool = false
    var scene: GameScene!
    var pathfinding: Pathfinding?
    var enemies = [Enemy]()
    var players = [Actor]()
    var mountains = [Mountain]()
    var holes = [Hole]()
    var objectives = [Objective]()
    var grid: Grid?
    var tutorialIndex = 1
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
        self.pathfinding = Pathfinding()
    }
    
    func destroy() {
        for p in self.players {
            p.removeFromParent()
        }
        self.players.removeAll()
        
        for e in self.enemies {
            e.removeFromParent()
        }
        self.enemies.removeAll()
        
        for m in self.mountains {
            m.removeFromParent()
        }
        self.mountains.removeAll()
        
        for h in self.holes {
            h.removeFromParent()
        }
        self.holes.removeAll()
        
        for o in self.objectives {
            o.removeFromParent()
        }
        self.objectives.removeAll()
        
        currentCharacter = nil
        grid = nil
        pathfinding = nil
        
        print("GameManager destroy: \(self.players.count), \(self.enemies.count), \(self.mountains.count), \(self.holes.count), \(self.objectives.count)")
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
            entity.tile.character = entity as? Actor
        } else {
            if let mountain = entity as? Mountain {
                mountains.append(mountain)
            } else if let hole = entity as? Hole {
                holes.append(hole)
            } else if let objective = entity as? Objective {
                objectives.append(objective)
            }
            entity.tile.prop = entity
        }
        grid?.addChild(entity)
    }
    
    func removeSelf(_ entity: Entity) {
        if let actor = entity as? Actor {
            if let enemy = entity as? Enemy {
                guard let index = enemies.firstIndex(of: enemy) else { fatalError("removeSelf(): enemy index returned nil") }
                enemies.remove(at: index)
            } else {
                guard let index = players.firstIndex(of: actor) else { fatalError("removeSelf(): player index returned nil") }
                players.remove(at: index)
            }
            actor.tile.character = nil
        } else {
            if let mountain = entity as? Mountain {
                guard let index = mountains.firstIndex(of: mountain) else { fatalError("removeSelf(): mountain index returned nil") }
                mountains.remove(at: index)
            } else if let hole = entity as? Hole {
                guard let index = holes.firstIndex(of: hole) else { fatalError("removeSelf(): hole index returned nil") }
                holes.remove(at: index)
            } else if let objective = entity as? Objective {
                guard let index = objectives.firstIndex(of: objective) else { fatalError("removeSelf(): hole index returned nil") }
               objectives.remove(at: index)
            }
            entity.tile.prop = nil
        }
        entity.removeFromParent()
    }
    
    func endTurn() {
        if players.isEmpty || enemies.isEmpty {
            if scene.level.tutorialText != nil {
                scene.loadNextTutorial()
                return
            }
            scene.loadEndGameScene()
            return
        }
        Button.unpressAll()
        grid?.removeHighlights()
        self.currentCharacter = nil
        enemyTurn()
    }
    
    func beginTurn() {
        for p in players {
            p.beginTurn()
        }
        if currentCharacter != nil {
            currentCharacter!.shader = self.highlightShader
            currentCharacter!.showMoveOptions()
        }
    }
    
    func touchTile(tile: Tile) {
        guard let grid = grid else { fatalError() }
        func selectCharacter(character: Actor) {
            Button.unpressAll()
            Button.showAll()
            grid.removeHighlights()
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
        
        if mode == .clear {
            if tile.character != nil {
                if tile.character is Enemy {
                    return
                } else {
                    if tile.character is Enemy { return }
                    selectCharacter(character: tile.character!)
                }
            }
        } else if grid.ableTiles.contains(tile) {
            if mode == .move {
                self.currentCharacter?.walk(tile: tile)
                mode = .attack
            } else if mode == .attack {
                self.currentCharacter?.basicAttack(tile: tile, completion: {})
                deselectCharacter()
            } else if mode == .specialAttack {
                self.currentCharacter?.specialAttack(tile: tile, completion: {})
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
    
    func onAttackButtonPress() {
        self.mode = .attack
    }
    
    func onAttackButtonUnpress() {
        if self.currentCharacter == nil {
            self.mode = .clear
        } else {
            self.mode = .move
        }
    }
    
    func onSpecialAttackButtonPress() {
        self.mode = .specialAttack
    }
    
    func onSpecialAttackButtonUnpress() {
        if self.currentCharacter == nil {
            self.mode = .clear
        } else {
            self.mode = .move
        }
    }
    
    func onEndTurnButtonPress() {
        endTurn()
    }
    
    func enemyTurn() {
        animating = true
        MachineController.shared.enemyMove(enemies: enemies, completion: {
            print("ended enemy move")
            self.beginTurn()
            self.animating = false
        })
    }
}
