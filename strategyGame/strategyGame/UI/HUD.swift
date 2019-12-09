//
//  HUD.swift
//  strategyGame
//
//  Created by Wolfgang Walder on 22/10/19.
//  Copyright © 2019 teamStrategyGame. All rights reserved.
//

let healthBarScale = 0.60

import SpriteKit

class HUD: SKShapeNode {
    var upperScrnArea: SKShapeNode
    var gridScreenArea: SKShapeNode
    var lowerScrnArea: SKShapeNode
    var endTurnBtn: EndTurnButton
    var attackBtn: AttackButton
    var spAttackBtn: SpecialAttackButton
    var settingsBtn: GearButton
    var levelName: SKLabelNode
    var movementDescription: SKLabelNode
    static var playerHealthBarList: [HealthBar] = []
    static var enemyHealthBarList: [HealthBar] = []
    static var objectiveHealthBarList: [HealthBar] = []
    
    init(rect: CGRect) {
        HUD.playerHealthBarList.removeAll()
        HUD.enemyHealthBarList.removeAll()
        HUD.objectiveHealthBarList.removeAll()
        
        upperScrnArea = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 770), size: CGSize(width: 414, height: 140)))
        gridScreenArea = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 210), size: CGSize(width: 414, height: 560)))
        lowerScrnArea = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 414, height: 210)))
        endTurnBtn = EndTurnButton(rect: CGRect(x: 120, y: 50, width: 107*buttonScale, height: 39*buttonScale), text: "End Turn")
        attackBtn = AttackButton(rect: CGRect(x: 15, y: 130, width: 107*buttonScale, height: 39*buttonScale), text: "Attack")
        spAttackBtn = SpecialAttackButton(rect: CGRect(x: 225, y: 130, width: 107*buttonScale, height: 39*buttonScale), text: "Special")
        settingsBtn = GearButton(rect: CGRect(x: 10, y: 800, width: 50*buttonScale, height: 20*buttonScale), text: " ")
        levelName = SKLabelNode(fontNamed: "Copperplate-Light")
        levelName.text = "LevelName"
        levelName.fontSize = 20
        levelName.fontColor = SKColor.black
        
        movementDescription = SKLabelNode(fontNamed: "Helvetica")
        movementDescription.text = "Click on a tile to select it. To move a character,click on them, then, click on one og the highlighted tiles to move to it."
        movementDescription.fontSize = 20
        movementDescription.fontColor = SKColor.black
        
        super.init()
        
        self.position = CGPoint(x: rect.minX, y: rect.minY)
        self.path = CGPath(rect: rect, transform: nil)
        levelName.position = CGPoint(x: frame.midX, y: 800)
        movementDescription.position = CGPoint(x: 20, y: 100)
        
        upperScrnArea.strokeColor = .clear
        gridScreenArea.strokeColor = .clear
        lowerScrnArea.strokeColor = .clear
        
        self.upperScrnArea.addChild(settingsBtn)
        self.addChild(upperScrnArea)
        self.addChild(gridScreenArea)
        self.addChild(lowerScrnArea)
        self.lowerScrnArea.addChild(endTurnBtn)
        self.lowerScrnArea.addChild(attackBtn)
        self.lowerScrnArea.addChild(spAttackBtn)
        self.upperScrnArea.addChild(levelName)
        self.lowerScrnArea.addChild(movementDescription)
        
        Button.hideAttackButtons()
        
        for i in (0..<GameManager.shared.players.count) {
            HUD.playerHealthBarList.append(HealthBar(rect: CGRect(origin: CGPoint(x: 10, y: -33), size: CGSize(width: 39*healthBarScale, height: 39*healthBarScale)), text: "\(GameManager.shared.players[i].health)"))
            
            HUD.playerHealthBarList[i].zPosition = 1.0
            
            GameManager.shared.players[i].addChild(HUD.playerHealthBarList[i])
        }
        
        for i in (0..<GameManager.shared.enemies.count) {
            HUD.enemyHealthBarList.append(HealthBar(rect: CGRect(origin: CGPoint(x: 10, y: -33), size: CGSize(width: 39*healthBarScale, height: 39*healthBarScale)), text: "\(GameManager.shared.enemies[i].health)"))

            HUD.enemyHealthBarList[i].zPosition = 1.0

            GameManager.shared.enemies[i].addChild(HUD.enemyHealthBarList[i])
        }
        
        for i in (0..<GameManager.shared.objectives.count) {
            HUD.objectiveHealthBarList.append(HealthBar(rect: CGRect(origin: CGPoint(x: 10, y: -33), size: CGSize(width: 39*healthBarScale, height: 39*healthBarScale)), text: "\(GameManager.shared.objectives[i].health)"))
            
            HUD.objectiveHealthBarList[i].zPosition = 1.0
            
            GameManager.shared.objectives[i].addChild(HUD.objectiveHealthBarList[i])
        }
    }
    
    static func updateHealthBars() {
        for i in (0..<GameManager.shared.players.count) {
            HUD.playerHealthBarList[i].label.text = "\(GameManager.shared.players[i].health)"
        }
        
        for i in (0..<GameManager.shared.enemies.count) {
            HUD.enemyHealthBarList[i].label.text = "\(GameManager.shared.enemies[i].health)"
        }
        
        for i in (0..<GameManager.shared.objectives.count) {
            HUD.objectiveHealthBarList[i].label.text = "\(GameManager.shared.objectives[i].health)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
