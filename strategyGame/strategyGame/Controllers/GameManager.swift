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
    }
    
    static let shared: GameManager = GameManager()
    var enemies: [MachineControlled]?
    var players: [Actor] = [Actor]()
    var grid: Grid?
    var currentCharacter: Actor?
    
    var mode: Mode {
        didSet {
            if currentCharacter == nil {
                return
            } else {
                if mode == .attack {
                    grid?.showAttackOptions(character: self.currentCharacter!)
                } else if mode == .move {
                    grid?.showMoveOptions(character: self.currentCharacter!)
                } else {
                    grid?.removeHighlights()
                }
            }
        }
    }
    
    private init() {
        mode = .clear
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
        grid.addChild(melee)
        players.append(melee)
        let ranged = Ranged(tile: grid.tiles[15])
        grid.addChild(ranged)
        players.append(ranged)
        let trapper = Trapper(tile: grid.tiles[34])
        grid.addChild(trapper)
        players.append(trapper)

    }
    
    private func makeValidMove(character: Actor, tile: Tile?) {
        if tile == nil { return }
        if !(self.grid?.ableTiles.contains(tile!) ?? false) { return }
        grid?.removeHighlights()
        currentCharacter?.move(tile: tile!)
        currentCharacter = nil
    }

    func touchTile(tile: Tile) {
        func selectCharacter(character: Actor) {
            grid?.removeHighlights()
            currentCharacter = character
            if self.mode == .attack {
                grid?.showAttackOptions(character: currentCharacter!)
            } else {
                grid?.showMoveOptions(character: currentCharacter!)
            }
        }
        
        guard let currentCharacter = self.currentCharacter else {
            if let char = tile.character {
                selectCharacter(character: char)
            }
            return
        }
        
        if tile.character == currentCharacter {
            return
        } else if tile.character == nil && self.mode != .attack {
            makeValidMove(character: currentCharacter, tile: tile)
        } else if self.mode == .attack && tile.character != nil {
            attack(attacker: currentCharacter, attacked: tile.character!)
        } else {
            grid?.removeHighlights()
            self.currentCharacter = nil
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
