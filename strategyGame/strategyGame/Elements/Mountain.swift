//
//  Mountain.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 19/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Mountain: Element {
    
    init(tile: Tile) {
        super.init(name: "Mountain", sprite: SKTexture(imageNamed: "x"), tile: tile, qntdTurnStunned: 1)
        //        let animation = SKAction.animate(with: AnimationHandler.shared.trapperFrames, timePerFrame: 1/TimeInterval(5))
        //        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
