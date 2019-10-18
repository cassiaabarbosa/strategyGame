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
    public private(set) var damage: Int
    public private(set) var health: Int
    public private(set) var attackRange: Int
    public private(set) var tile: Tile {
        didSet {
            tile.character = self
        }
    }
    var breadcrumbs: [Tile] = [Tile]()
    var wholeNumberValue: Float?
    var canMove: Bool = true
    
    init(name: String, movement: Int, damage: Int, health: Int, attackRange: Int, sprite: SKTexture, tile: Tile) {
        self.movement = movement
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
        move(tile: tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func basicAttack() -> [Int] {
        return [damage, attackRange]
    }
    
    func specialAttack() {}
    
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
    }
}
