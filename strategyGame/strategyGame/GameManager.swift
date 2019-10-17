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
    }
    var turnPhase: Phase
    
    private init() {
        let melee: Melee = Melee(name: "Melee1", movement: 2, coord: (1, 1), sprite: SKTexture(imageNamed: "OysterVolcano"), state: State.idle, damage: 1, health: 3, attackRange: 1)
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
        players[0].position = grid.tiles[21].position
        players[0].position.x += grid.tiles[21].center.x
        players[0].position.y += grid.tiles[21].center.y
        players[0].size = grid.tileSize
        grid.addChild(players[0])
        players[0].breadcrumbs.append(grid.tiles[21])
    }
    
    func makeAMovement(tile: Tile) {
        currentCharacter?.position = tile.position
        currentCharacter?.position.x += tile.center.x
        currentCharacter?.position.y += tile.center.y
        currentCharacter?.breadcrumbs.removeAll()
        currentCharacter?.breadcrumbs.append(tile)
        currentCharacter = nil
    }
    
    func showTilesPath(grid: Grid?) {
        guard let move: Int = currentCharacter?.movement else { return }
        guard let currentTileIndex: Int = currentCharacter?.breadcrumbs[0].id else { return }
        guard let grid: Grid = grid else { return }
        var ableTiles: [Tile] = [Tile]()
        for tile in grid.tiles {
            for select in 0...move {
                if (tile.id == currentTileIndex + select) {
                    ableTiles.append(tile)
                }
                if (tile.id == currentTileIndex - select) {
                    ableTiles.append(tile)
                }
                if (tile.id == currentTileIndex + (select * 6)) {
                    ableTiles.append(tile)
                }
                if (tile.id == currentTileIndex - (select * 6)) {
                    ableTiles.append(tile)
                }
            }
        }
        
        for tiles in ableTiles {
            tiles.shape?.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
