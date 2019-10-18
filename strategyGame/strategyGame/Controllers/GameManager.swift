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
    
    static let shared: GameManager = GameManager()
    var enemies: [MachineControlled]?
    var players: [Actor] = [Actor]()
    var grid: Grid?
    var currentCharacter: Actor?
    enum Phase {
        case playerMove
        case playerAttack
        case enemyMove
    }
    var turnPhase: Phase
    
    private init() {
        turnPhase = .playerMove
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareToPlay() {
        print("Preparing...")
    }
    
    func setActorsOnGrid(gameScene: GameScene, grid: Grid) {
        self.grid = grid
        let melee = Melee(tile: grid.tiles[21])
        let melee2 = Melee(tile: grid.tiles[15])
        grid.addChild(melee)
        grid.addChild(melee2)
        players.append(melee)
        players.append(melee2)
    }
    
    private func showTilesPath() {
        guard let move: Int = currentCharacter?.movement else { return }
        guard let currentTile: Tile = currentCharacter?.tile else { return }
        guard let grid: Grid = self.grid else { return }
            grid.ableTiles.append(currentTile)
        // TODO: Colocar método na classe Grid
        for mov in 0...move {
            if let tile = grid.getTile(col: currentTile.coord.col + 1 * mov, row: currentTile.coord.row) {
                grid.ableTiles.append(tile)
            }
            if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row + 1 * mov) {
                grid.ableTiles.append(tile)
            }
            if let tile = grid.getTile(col: currentTile.coord.col - 1 * mov, row: currentTile.coord.row) {
                grid.ableTiles.append(tile)
            }
            if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row - 1 * mov) {
                grid.ableTiles.append(tile)
            }
        }
        for tiles in grid.ableTiles {
            tiles.shape?.fillShader = Tile.highlightShader
        }
    }
    
    func removeHighlights() {
        guard let grid = self.grid else {
            print("removeHighlights(): grid is nil")
            return
        }
        for til in grid.ableTiles {
            til.shape?.fillShader = nil
        }
        grid.ableTiles.removeAll()
    }
    
    private func showAttackOptions() {
        guard let currentTile: Tile = currentCharacter?.tile else { return }
        guard let grid: Grid = self.grid else { return }
        if let tile = grid.getTile(col: currentTile.coord.col + 1, row: currentTile.coord.row) {
            grid.ableTiles.append(tile)
        }
        if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row + 1) {
            grid.ableTiles.append(tile)
        }
        if let tile = grid.getTile(col: currentTile.coord.col - 1, row: currentTile.coord.row) {
            grid.ableTiles.append(tile)
        }
        if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row - 1) {
            grid.ableTiles.append(tile)
        }
        for tiles in grid.ableTiles {
            tiles.shape?.fillShader = Tile.attackHighlightShader
        }
    }
    
    // TODO: implementar método move() na classe Actor
    // validateMovement() deve ser feito pela classe Grid
    // após validada, chamar método move() do actor
    private func makeValidMove(character: Actor, tile: Tile?) {
        if tile == nil { return }
        if !(self.grid?.ableTiles.contains(tile!) ?? false) { return }
        removeHighlights()
        currentCharacter?.move(tile: tile!)
        currentCharacter = nil
    }

    func touchTile(tile: Tile) {
        func selectCharacter(character: Actor) {
            removeHighlights()
            currentCharacter = character
            if self.turnPhase == .playerAttack {
                showAttackOptions()
            } else {
                showTilesPath()
            }
        }
        
        guard let char = self.currentCharacter else {
            if let char = tile.character {
                selectCharacter(character: char)
            }
            return
        }
        
        if tile.character == char {
            return
        } else if tile.character == nil {
            makeValidMove(character: char, tile: tile)
        } else if turnPhase == .playerAttack {
            attack(attacker: char, attacked: tile.character!)
        } else {
            return
        }
    }
    
    func attack(attacker: Actor, attacked: Actor) {
        func push(character: Actor, to tile: Tile?) {
            if tile == nil { return }
            if tile!.prop == .standard {
                character.move(tile: tile!)
            } else {
                print("\(character.name!) took push damage")
                character.takeDamage(damage: 1)
            }
        }
        switch attacked.tile {
        case self.grid?.getUpTile(tile: attacker.tile):
            push(character: attacked, to: self.grid?.getUpTile(tile: attacked.tile))
        case self.grid?.getDownTile(tile: attacker.tile):
            push(character: attacked, to: self.grid?.getDownTile(tile: attacked.tile))
        case self.grid?.getLeftTile(tile: attacker.tile):
            push(character: attacked, to: self.grid?.getLeftTile(tile: attacked.tile))
        case self.grid?.getRightTile(tile: attacker.tile):
            push(character: attacked, to: self.grid?.getRightTile(tile: attacked.tile))
        default:
            print("GameManager.atack(): switch exausted")
        }
        attacked.takeDamage(damage: attacker.damage)
    }
}
