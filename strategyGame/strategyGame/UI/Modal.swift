//
//  Modal.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 09/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class Modal: SKSpriteNode {
    
    var backgroundTex = SKTexture(imageNamed: "modal")
    
    
    init(rect: CGRect) {
        super.init(texture: backgroundTex, color: .red, size: rect.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
