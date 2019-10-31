//
//  Tile.swift
//  Triangle Tiles Game
//
//  Created by Alex Nascimento on 07/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//
import SpriteKit

class Tile: SKSpriteNode {
    
    let id: Int
    var character: Actor?
    var prop: Entity?
    var weight: Int = 1000
    static let highlightShader: SKShader = SKShader(fileNamed: "HighlightShader.fsh")
    static let attackHighlightShader: SKShader = SKShader(fileNamed: "AttackHighlightShader.fsh")
    static let specialAttackHighlightShader: SKShader = SKShader(fileNamed: "SpecialAttackHighlightShader.fsh")
    public private(set) var coord: Coord
    var isOcupied: Bool {
        if character == nil {
            return false
        }
        return true
    }
    var hasTrap: Bool {
        if prop as? Trap != nil {
            return true
        }
        return false
    }
    var isEmpty: Bool {
        if prop == nil {
            return true
        }
        return false
    }
    var isWalkable: Bool {
        if prop as? Mountain != nil {
            return false
        }
        if prop as? Hole != nil {
            return false
        }
        if prop as? Objective != nil {
            return false
        }
        if self.isOcupied {
            return false
        }
        return true
    }
    var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                self.shader = Tile.highlightShader
            } else {
                self.shader = nil
            }
        }
    }
    
    var isSpecialHighlighted: Bool {
        didSet {
            if self.isSpecialHighlighted {
                self.shader = Tile.specialAttackHighlightShader
            } else {
                self.shader = nil
            }
        }
    }
    
    init (id: Int, row: Int, col: Int, rectSide: CGFloat, type: Character) {
        self.id = id
        self.isHighlighted = false
        self.isSpecialHighlighted = false
        self.coord = Coord(row, col)
        super.init(texture: SKTexture(imageNamed: "Tile"), color: .white, size: CGSize(width: rectSide, height: rectSide))
        self.position = CGPoint(x: CGFloat(col) * rectSide + rectSide/2, y: CGFloat(row) * -rectSide + rectSide/2)
        self.zPosition = -5
        
        var entity = Entity(name: "empty", sprite: SKTexture(), tile: self)
        switch type {
        case "M":
            entity = Melee(tile: self)
            self.character = entity as? Actor
        case "R":
            entity = Ranged(tile: self)
            self.character = entity as? Actor
        case "T":
            entity = Trapper(tile: self)
            self.character = entity as? Actor
        case "c":
            entity = HeavyEnemy(tile: self)
            self.character = entity as? Actor
        case "v":
            entity = SprinterEmeny(tile: self)
            self.character = entity as? Actor
        case "m":
            entity = Mountain(tile: self)
            self.prop = entity
        case "h":
            entity = Hole(tile: self)
            self.prop = entity
        case "s":
            entity = Objective(tile: self, type: .sun)
            self.prop = entity
        case "l":
            entity = Objective(tile: self, type: .moon)
            self.prop = entity
        default:
            self.prop = nil
        }
        if entity.name != "empty" {
            GameManager.shared.addSelf(entity)
        }
    }
    
    func push(direction: Int) {
        let character = self.character
        let trap = self.prop as? Trap
        
        guard let grid = GameManager.shared.grid else { return }
        var tile: Tile?
        switch(direction) {
        case 0:
            tile = grid.getUpTile(tile: self)
        case 1:
            tile = grid.getDownTile(tile: self)
        case 2:
            tile = grid.getLeftTile(tile: self)
        case 3:
            tile = grid.getRightTile(tile: self)
        default:
            print("Tile::push(): direction out of range")
            return
        }
        if tile != nil {
            character?.push(to: tile!, from: self)
            trap?.push(to: tile!, from: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
