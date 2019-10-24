//
//  HUD.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 22/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

import SpriteKit

class HUD: SKShapeNode {
    var upperScrnArea: SKShapeNode
    var lowerScrnArea: SKShapeNode
    var endTurnBtn: EndTurnButton
    var attackBtn: AttackButton
    var spAttackBtn: SpecialAttackButton
    
    init(rect: CGRect) {
        upperScrnArea = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 770), size: CGSize(width: 414, height: 140)))
        lowerScrnArea = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 414, height: 210)))
        endTurnBtn = EndTurnButton(rect: CGRect(x: 120, y: 50, width: 107*buttonScale, height: 39*buttonScale), text: "End Turn")
        attackBtn = AttackButton(rect: CGRect(x: 15, y: 130, width: 107*buttonScale, height: 39*buttonScale), text: "Attack")
        spAttackBtn = SpecialAttackButton(rect: CGRect(x: 225, y: 130, width: 107*buttonScale, height: 39*buttonScale), text: "Special")
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
