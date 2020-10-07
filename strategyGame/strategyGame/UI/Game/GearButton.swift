//
//  GearButton.swift
//  strategyGame
//
//  Created by Cassia Aparecida Barbosa on 09/12/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class GearButton: Button {
    
    init(rect: CGRect,  action: @escaping () -> Void) {
        super.init(rect: rect, text: "", action:  action)
        self.buttonNormalTex = SKTexture(imageNamed: "settingsbutton")
        self.buttonPressedTex = SKTexture(imageNamed: "SettingsButtonPressed")
        self.texture = SKTexture(imageNamed: "settingsbutton")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
