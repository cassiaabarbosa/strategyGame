//
//  LevelDescription.swift
//  strategyGame
//
//  Created by Alex Nascimento on 06/10/20.
//  Copyright © 2020 teamStrategyGame. All rights reserved.
//

import Foundation

struct LevelDescription {
    
    var width: Int
    var height: Int
    var tileSet: String
    
    init(width: Int, height: Int, tileSet: String) {
        if tileSet.count != width * height {
            print("WARNING - tileSet doesn't match width and height")
        }
        self.width = width
        self.height = height
        self.tileSet = tileSet
    }
}
