//
//  Trap.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 17/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import Foundation
import SpriteKit

class Trap: Element {
    
    init(tile: Tile) {
        super.init(name: "Trap", sprite: SKTexture(imageNamed: "OysterVolcano"), tile: tile, qntdTurnStunned: 1)
//        let animation = SKAction.animate(with: AnimationHandler.shared.trapperFrames, timePerFrame: 1/TimeInterval(5))
//        self.run(SKAction.repeatForever(animation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activeTrap(toTile: Tile?) {
        //colide com um actor
        
    }
}
