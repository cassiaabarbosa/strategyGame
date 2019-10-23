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
        super.init(name: "Mountain", sprite: SKTexture(imageNamed: "00_mountain"), tile: tile, qntdTurnStunned: 1)
        let animation = SKAction.animate(with: AnimationHandler.shared.mountainFrames, timePerFrame: 1/TimeInterval(18))
        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
