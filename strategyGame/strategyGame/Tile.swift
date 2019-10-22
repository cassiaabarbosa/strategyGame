//
//  Tile.swift
//  Triangle Tiles Game
//
//  Created by Alex Nascimento on 07/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import SpriteKit

enum TileProps {
    case standard
    case mountain
    case trap
    case hole
}

class Tile: SKSpriteNode {
    
    let id: Int
    var character: Actor?
    var prop: TileProps = .standard
    static let highlightShader: SKShader = SKShader(fileNamed: "HighlightShader.fsh")
    static let attackHighlightShader: SKShader = SKShader(fileNamed: "AttackHighlightShader.fsh")
    public private(set) var coord: Coord
    var isOcupied: Bool {
        if character == nil {
            return false
        }
        return true
    }
    var hasTrap: Bool {
        if prop == .trap {
            return true
        }
        return false
    }
    var isEmpty: Bool {
        if !isOcupied && prop == .standard {
            return true
        }
        return false
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
    
    init (id: Int, row: Int, col: Int, rectSide: CGFloat, type: Character) {
        self.id = id
        self.isHighlighted = false
        self.coord = Coord(row, col)
        super.init(texture: SKTexture(imageNamed: "Tile"), color: .white, size: CGSize(width: rectSide, height: rectSide))
        self.position = CGPoint(x: CGFloat(col) * rectSide + rectSide/2, y: CGFloat(row) * -rectSide + rectSide/2)
        self.zPosition = -5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
