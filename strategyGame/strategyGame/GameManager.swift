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
            print(self.currentCharacter?.sprite)
        }
    }
    enum Phase {
        case playerMove
        case enemyMove
    }
    var turnPhase: Phase
    
    private init() {
        let melee: Melee = Melee(name: "Melee1", movement: 2, coord: (1, 1), sprite: SKTexture(imageNamed: "Flownace"), state: State.idle, damage: 1, health: 3, attackRange: 1)
        players.append(melee)
        turnPhase = .playerMove
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareToPlay() {
        print("Preparing...")
    }
    
    func moveOnBoard(currentCharacter: Actor, tile: Tile) {
        currentCharacter.position = tile.position
    }
    
    func setActorsOnGrid(gameScene: GameScene, grid: Grid) {
        grid.addChild(players[0])
        players[0].position = grid.tiles[21].center
        players[0].size = grid.tileSize
        players[0].breadcrumbs.append(grid.tiles[21])
    }
    
    func makeAMovement(tile: Tile) {
        if !(currentCharacter?.breadcrumbs.contains(tile) ?? false) { return }
        guard let grid = self.grid else { return }
        for til in grid.tiles {
            til.isHighlighted = false
        }
        currentCharacter?.position = tile.center
        currentCharacter?.breadcrumbs.removeAll()
        currentCharacter?.breadcrumbs.append(tile)
        currentCharacter = nil
    }
    
    func showTilesPath() {
        guard let move: Int = currentCharacter?.movement else { return }
        guard let currentTile: Tile = currentCharacter?.breadcrumbs[0] else { return }
        guard let grid: Grid = self.grid else { return }
        var ableTiles: [Tile] = [Tile]()
        if let tile = grid.getTile(col: currentTile.coord.col, row: currentTile.coord.row) {
            ableTiles.append(tile)
        }
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
            tiles.shape?.fillShader = Tile.highlightShader
        }
    }
}
