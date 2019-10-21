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
    var currentCharacter: Actor? {
        didSet {
            print(self.currentCharacter?.sprite as Any)
        }  
    }
    enum Phase {
        case playerMove
        case playerAttack
        case enemyMove
    }
    var turnPhase: Phase
    
    private init() {
        let melee: Melee = Melee(name: "Melee1", movement: 2, coord: (1, 1), sprite: SKTexture(imageNamed: "OysterVolcano"), state: State.idle, damage: 1, health: 3, attackRange: 1)
        let melee2: Melee = Melee(name: "Melee2", movement: 3, coord: (1, 1), sprite: SKTexture(imageNamed: "Melee"), state: State.idle, damage: 1, health: 3, attackRange: 1)
        players.append(melee)
        players.append(melee2)
        turnPhase = .playerMove
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareToPlay() {
        print("Preparing...")
    }
    
    func setActorsOnGrid(gameScene: GameScene, grid: Grid) {
        grid.addChild(players[0])
        players[0].position = grid.tiles[21].center
        players[0].size = grid.tileSize
        players[0].breadcrumbs.append(grid.tiles[21])
        grid.tiles[21].character = players[0]
        
        grid.addChild(players[1])
        players[1].position = grid.tiles[12].center
        players[1].size = grid.tileSize
        players[1].breadcrumbs.append(grid.tiles[12])
        grid.tiles[12].character = players[1]
        grid.testRoundTiles(tile: grid.tiles[21])
    }
    
    private func showTilesPath() {
        guard let move: Int = currentCharacter?.movement else { return }
        guard let currentTile: Tile = currentCharacter?.breadcrumbs[0] else { return }
        guard let grid: Grid = self.grid else { return }
        var ableTiles: [Tile] = [Tile]()
        if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row) {
            ableTiles.append(tile)
        }
        // TODO: Colocar método na classe Grid
        for mov in 0...move {
            if let tile = grid.getTile(col: currentTile.coord.col + 1 * mov, row: currentTile.coord.row) {
                ableTiles.append(tile)
            }
            if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row + 1 * mov) {
                ableTiles.append(tile)
            }
            if let tile = grid.getTile(col: currentTile.coord.col - 1 * mov, row: currentTile.coord.row) {
                ableTiles.append(tile)
            }
            if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row - 1 * mov) {
                ableTiles.append(tile)
            }
        }
        
        currentCharacter?.breadcrumbs = ableTiles
        for tiles in ableTiles {
            tiles.shape?.fillShader = Tile.highlightShader
        }
    }
    
    func removeHighlights() {
        guard let grid = self.grid else {
            print("removeHighlights(): grid is nil")
            return
        }
        for til in grid.tiles {
            til.shape?.fillShader = nil
        }
    }
    
    private func showAttackOptions() {
        guard let currentTile: Tile = currentCharacter?.breadcrumbs[0] else { return }
        guard let grid: Grid = self.grid else { return }
        var ableTiles: [Tile] = [Tile]()
        if let tile = grid.getTile(col: currentTile.coord.col + 1, row: currentTile.coord.row) {
            ableTiles.append(tile)
        }
        if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row + 1) {
            ableTiles.append(tile)
        }
        if let tile = grid.getTile(col: currentTile.coord.col - 1, row: currentTile.coord.row) {
            ableTiles.append(tile)
        }
        if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row - 1) {
            ableTiles.append(tile)
        }
        currentCharacter?.breadcrumbs = ableTiles
        for tiles in ableTiles {
            tiles.shape?.fillShader = Tile.attackHighlightShader
        }
    }
    
    // TODO: implementar método move() na classe Actor
    // validateMovement() deve ser feito pela classe Grid
    // após validada, chamar método move() do actor
    private func makeValidMove(character: Actor,tile: Tile) {
        if !(currentCharacter?.breadcrumbs.contains(tile) ?? false) { return }
        removeHighlights()
        character.tile.character = nil
        currentCharacter?.position = tile.center
        currentCharacter?.breadcrumbs.removeAll()
        currentCharacter?.breadcrumbs.append(tile)
        tile.character = currentCharacter
        currentCharacter = nil
    }

    func touchTile(tile: Tile) {
        func selectCharacter(character: Actor) {
            removeHighlights()
            currentCharacter = character
            print(self.turnPhase)
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
        // lógica de empurrar vai aqui
        attacked.health -= attacker.damage
    }
}
