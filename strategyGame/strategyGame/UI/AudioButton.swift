//
//  AudioButton.swift
//  strategyGame
//
<<<<<<< HEAD
//  Created by Cassia Aparecida Barbosa on 08/12/19.
=======
//  Created by Cassia Aparecida Barbosa on 09/12/19.
>>>>>>> develop
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class AudioButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: " ")
    }
    
    override func press() {
        self.pressed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
