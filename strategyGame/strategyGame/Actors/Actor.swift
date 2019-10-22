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
        self.position = tile.center
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
            print("\(self.name!) is dead")
        }
    }
    
    func move(tile: Tile) {
        self.tile.character = nil
        self.position = tile.center
        self.tile = tile
        self.movesLeft = 0 // TODO: substituir quando implementado o pathfinding (ir decrementando até chegar em zero)
    }
    
    func makeValidMove(tile: Tile?) {
        guard let grid = GameManager.shared.grid else { return }
        if tile == nil { return }
        if !(grid.ableTiles.contains(tile!)) { return }
        grid.removeHighlights()
        self.move(tile: tile!)
        GameManager.shared.currentCharacter = nil
    }
    
    // TO-DO:
    // esse método está aqui por conveniência.
    // Coloque nas subclasses quando for implementar os ataques especificos de cada uma
    // fazer com overload, deixando o método em Actor vazio: func basicAttack() {}
    func basicAttack(target: Actor) {
        if self.isExausted {
            print("\(self.name!) is exausted")
            return
        }
        func push(character: Actor, to tile: Tile?) {
            if tile == nil { return }
            if tile!.prop == .standard {
                character.move(tile: tile!)
            } else {
                print("\(character.name!) took push damage")
                character.takeDamage(damage: 1)
            }
        }
        guard let grid = GameManager.shared.grid else { return }
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
            return
        }
        target.takeDamage(damage: self.damage)
        isExausted = true
    }
    
    func specialAttack(toTile: Tile) {}
    
    func showMoveOptions() {
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        if self.movesLeft == 0 { return }
        let tiles = grid.getTilesAround(tile: self.tile, distance: self.movesLeft)
        for t in tiles {
            grid.ableTiles.append(t)
        }
        for t in grid.ableTiles {
           t.shape?.fillShader = Tile.highlightShader
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
           t.shape?.fillShader = Tile.attackHighlightShader
        }
    }
    
    //essa função ainda só funciona se o ataque partir do trapper
    func showSpecialAttackOptions() {
        guard let grid = GameManager.shared.grid else { return }
        grid.removeHighlights()
        for t in 0...grid.tiles.count - 1 {
            if (grid.tiles[t].isOcupied == false && grid.tiles[t].hasTrap == false) {
                grid.ableTiles.append(grid.tiles[t])
            }
        }
        
        for t in grid.ableTiles {
            t.shape?.fillShader = Tile.highlightShader
        }
    }
    
    func beginTurn() {
        self.movesLeft = movement
        self.isExausted = false
    }
}
