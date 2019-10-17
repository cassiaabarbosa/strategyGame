//
//  Tile.swift
//  Triangle Tiles Game
//
//  Created by Alex Nascimento on 07/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import SpriteKit

class Tile: SKNode {
    
    let id: Int
    var isOcupied: Bool
    var clear: Bool
    var isHighlighted: Bool {
        didSet {
            if shape == nil { return }
            if self.isHighlighted {
                shape?.fillShader = Tile.highlightShader
            } else {
                shape?.fillShader = nil
            }
        }
    }
    static let highlightShader: SKShader = SKShader(fileNamed: "HighlightShader.fsh")
    public private(set) var shape: SKShapeNode?
    public private(set) var coord: Coord
    public private(set) var center: CGPoint
    public private(set) var size: CGSize
    
    init (id: Int, row: Int, col: Int, rectSide: CGFloat, type: Character) {
        self.id = id
        print(id)
        self.isOcupied = false
        self.clear = true
        self.size = CGSize(width: rectSide, height: rectSide)
        self.center = CGPoint.zero
        self.isHighlighted = false
        self.coord = Coord(row, col)
        super.init()
        self.position = CGPoint(x: CGFloat(col) * rectSide, y: CGFloat(row) * -rectSide)
        self.center = CGPoint(x: self.position.x + self.size.width/2,
                              y: self.position.y + self.size.height/2)
        drawTile(char: type)
    }
    
    func drawTile(char: Character) {
        self.shape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        self.shape!.strokeColor = .black
        self.shape!.lineWidth = 2
        self.shape!.fillColor = UIColor(hue: CGFloat(char.wholeNumberValue ?? 0) / 10, saturation: 0.6, brightness: 0.8, alpha: 1)
        addChild(shape!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
