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
    var prop: Element?
    var weight: Int = 1000
    static let highlightShader: SKShader = SKShader(fileNamed: "HighlightShader.fsh")
    static let attackHighlightShader: SKShader = SKShader(fileNamed: "AttackHighlightShader.fsh")
    static let specialAttackHighlightShader: SKShader = SKShader(fileNamed: "SpecialAttackHighlightShader.fsh")
    public private(set) var coord: Coord
    var hasObstacle: Bool {
        if prop as? Mountain != nil {
            return true
        }
        
        if prop as? Hole != nil {
            return true
        }
        
        if character as? Enemy != nil {
            return true
        }
        return false
    }
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
        
        switch type {
        case "M":
            let melee = Melee(tile: self)
            self.character = melee
            GameManager.shared.players.append(melee)
        case "R":
            let ranged = Ranged(tile: self)
            self.character = ranged
            GameManager.shared.players.append(ranged)
        case "T":
            let trapper = Trapper(tile: self)
            self.character = trapper
            GameManager.shared.players.append(trapper)
        case "c":
            let heavy = HeavyEnemy(tile: self)
            self.character = heavy
            GameManager.shared.enemies.append(heavy)
        case "v":
            let sprinter = SprinterEmeny(tile: self)
            self.character = sprinter
            GameManager.shared.enemies.append(sprinter)
        case "m":
            let mountain = Mountain(tile: self)
            self.prop = mountain
            GameManager.shared.mountains.append(mountain)
        case "h":
            let hole = Hole(tile: self)
            self.prop = hole
            GameManager.shared.holes.append(hole)
        case "s":
            let sun = Objective(tile: self, type: .sun)
            self.prop = sun
            GameManager.shared.objectives.append(sun)
        case "l":
            let moon = Objective(tile: self, type: .moon)
            self.prop = moon
            GameManager.shared.objectives.append(moon)
        default:
            self.prop = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
