//
//  Character.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 15/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Actor: SKSpriteNode {
    
    var coord: Coord {
        return tile.coord
    }
    var sprite: SKTexture
    public private(set) var movement: Int
    public private(set) var movesLeft: Int
    public private(set) var damage: Int
    public private(set) var health: Int
    public private(set) var attackRange: Int
    public private(set) var tile: Tile {
        didSet {
            tile.character = self
        }
    }
    internal var isExausted: Bool = false
    var breadcrumbs: [Tile] = [Tile]()
    private var stunned: Int = 0
    var wholeNumberValue: Float?
    var canMove: Bool = true
    
    init(name: String, movement: Int, damage: Int, health: Int, attackRange: Int, sprite: SKTexture, tile: Tile) {
        self.movement = movement
        self.movesLeft = movement
        self.sprite = sprite
        self.damage = damage
        self.health = health
        self.attackRange = attackRange
        self.tile = tile
        super.init(texture: sprite, color: UIColor.clear, size: sprite.size())
        self.name = name
        self.position = tile.position
        self.size = tile.size
        self.isUserInteractionEnabled = false
        tile.character = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage(damage: Int) {
        self.health -= damage
        if (self.health <= 0) {
            self.die()
        }
        HUD.updateHealthBars()
    }
    
    private func die() {
        self.removeFromParent()
        if let enemySelf = self as? Enemy {
            GameManager.shared.enemies.remove(at: GameManager.shared.enemies.firstIndex(of: enemySelf)!)
        } else {
            GameManager.shared.players.remove(at: GameManager.shared.players.firstIndex(of: self)!)
        }
    }
    
    func move(tile: Tile) {
        self.tile.character = nil
        self.position = tile.position
        self.tile = tile
        self.movesLeft = 0 // TODO: substituir quando implementado o pathfinding (ir decrementando até chegar em zero)
    }
    
    func makeValidMove(tile: Tile?) -> Bool {
        guard let grid = GameManager.shared.grid else { return false }
        if tile == nil { return false }
        if !(grid.ableTiles.contains(tile!)) { return false }
        grid.removeHighlights()
        self.move(tile: tile!)
        return true
    }
    
    // TO-DO:
    // esse método está aqui por conveniência.
    // Coloque nas subclasses quando for implementar os ataques especificos de cada uma
    // fazer com overload, deixando o método em Actor vazio: func basicAttack() {}
    func basicAttack(target: Actor) -> Bool {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return false
        }
        func push(character: Actor, to tile: Tile?) {
            if tile == nil { return }
            if tile!.isEmpty {
                character.move(tile: tile!)
            } else if tile!.prop as? Hole != nil {
                character.removeFromParent()
            } else if tile!.prop as? Mountain != nil {
                character.takeDamage(damage: 1)
            } else if let trap = tile!.prop as? Trap {
                character.move(tile: tile!)
                trap.activateTrap(character: character)
            } else if tile!.prop as? Objective != nil {
                character.takeDamage(damage: 1)
            } else {
                print("Actor::push(): prop didn't conform to any Element")
            }
        }
        guard let grid = GameManager.shared.grid else { return false }
        switch target.tile {
        case grid.getUpTile(tile: self.tile):
            push(character: target, to: grid.getUpTile(tile: target.tile))
        case grid.getDownTile(tile: self.tile):
            push(character: target, to: grid.getDownTile(tile: target.tile))
        case grid.getLeftTile(tile: self.tile):
            push(character: target, to: grid.getLeftTile(tile: target.tile))
        case grid.getRightTile(tile: self.tile):
            push(character: target, to: grid.getRightTile(tile: target.tile))
        default:
            return false
        }
        target.takeDamage(damage: self.damage)
        isExausted = true
        return true
    }
    
    func basicAttack(target: Objective) -> Bool{
        if self.isExausted {
            print("\(self.name!) is exausted")
            return false
        }
        target.takeDamage()
        isExausted = true
        return true
    }
    
    func specialAttack(toTile: Tile) {}
    
    func showMoveOptions() {
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        if self.movesLeft == 0 { return }
        let tiles = grid.getReachableTiles(fromTile: self.tile, moves: movesLeft)
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.highlightShader
        }
    }
       
    func showAttackOptions() {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return
        }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: 1)
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shader = Tile.attackHighlightShader
        }
    }
    
    func showSpecialAttackOptions() {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return
        }
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        let tiles = grid.getTilesAround(tile: self.tile, distance: 1)
        for t in tiles {
            if t.isEmpty && !t.isOcupied {
                grid.ableTiles.append(t)
            }
        }
        for t in grid.ableTiles {
            t.isSpecialHighlighted = true
        }
    }
    
    func stun(turns: Int) {
        movesLeft = 0
        isExausted = true
        self.stunned = turns
    }
    
    func beginTurn() {
        if stunned > 0 {
            stun(turns: self.stunned)
            self.stunned -= 1
        } else {
            self.movesLeft = movement
            self.isExausted = false
        }
    }
}
