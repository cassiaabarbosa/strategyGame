//
//  HUD.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 22/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class HUD: SKShapeNode {
    let upperScrnArea: SKShapeNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 770), size: CGSize(width: 414, height: 140)))
    let lowerScrnArea: SKShapeNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 414, height: 210)))
    var endTurnBtn: EndTurnButton = EndTurnButton(rect: CGRect(x: 145, y: 20, width: 150, height: 80), text: "End Turn")
    var attackBtn: AttackButton = AttackButton(rect: CGRect(x: 40, y: 100, width: 120, height: 80), text: "Attack")
    var spAttackBtn: SpecialAttackButton = SpecialAttackButton(rect: CGRect(x: 250, y: 100, width: 120, height: 80), text: "Special")
    
    init(rect: CGRect) {
        super.init()
        self.position = CGPoint(x: rect.minX, y: rect.minY)
        self.path = CGPath(rect: rect, transform: nil)
        upperScrnArea.strokeColor = .clear
        lowerScrnArea.strokeColor = .clear
        self.addChild(upperScrnArea)
        self.addChild(lowerScrnArea)
        self.lowerScrnArea.addChild(endTurnBtn)
        self.lowerScrnArea.addChild(attackBtn)
        self.lowerScrnArea.addChild(spAttackBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
