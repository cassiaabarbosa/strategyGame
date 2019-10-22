//
//  Element.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 19/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Element: SKSpriteNode {
    
    var coord: Coord {
        return tile.coord
    }
    var sprite: SKTexture
    public private(set) var qntdTurnStunned: Int
    public private(set) var tile: Tile

    init(name: String, sprite: SKTexture, tile: Tile, qntdTurnStunned: Int) {
        self.sprite = sprite
        self.tile = tile
        self.qntdTurnStunned = qntdTurnStunned
        super.init(texture: sprite, color: UIColor.clear, size: sprite.size())
        self.name = name
        self.position = tile.position
        self.size = tile.size
        self.isUserInteractionEnabled = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setElement() {}
    
}
