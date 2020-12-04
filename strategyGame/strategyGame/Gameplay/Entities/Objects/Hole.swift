//
//  Hole.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 19/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Hole: Entity {
    
    init(tile: Tile) {
        super.init(name: "Hole", sprite: SKTexture(imageNamed: "holePixel"), tile: tile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit hole")
    }
}
