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
    var levelName: TextBox
    var moveDescription: TextBox
    var charName: TextBox
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
        endTurnBtn = EndTurnButton(rect: CGRect(x: 300, y: 40, width: 60*buttonScale, height: 60*buttonScale), text: "End")
        attackBtn = AttackButton(rect: CGRect(x: 15, y: 40, width: 107*buttonScale*0.75, height: 39*buttonScale*0.75), text: "Attack")
        spAttackBtn = SpecialAttackButton(rect: CGRect(x: 155, y: 40, width: 107*buttonScale*0.75, height: 39*buttonScale*0.75), text: "Special")
        settingsBtn = GearButton(rect: CGRect(x: 10, y: 800, width: 30*buttonScale, height: 30*buttonScale))
        levelName = TextBox(rect: CGRect(x: rect.midX, y: 800, width: 107, height: 39))
        moveDescription = TextBox(rect: CGRect(x: rect.midX, y: 100, width: 250, height: 100))
        charName = TextBox(rect: CGRect(x: rect.midX, y: 100, width: 107, height: 39))
        
        super.init()
        
        self.position = CGPoint(x: rect.minX, y: rect.minY)
        self.path = CGPath(rect: rect, transform: nil)
        
        levelName.position = CGPoint(x: frame.midX, y: 800)
        levelName.textLabel.fontName = "Helvetica-Bold"
        levelName.textLabel.text = "The Arena"
        levelName.textLabel.preferredMaxLayoutWidth = 107
        
        moveDescription.position = CGPoint(x: 2*(frame.midX/3)+10, y: 145)
        moveDescription.textLabel.fontName = "Helvetica"
        moveDescription.textLabel.text = "Touch a character to select them. You can either move, attack or use a special attack with each character."
        moveDescription.textLabel.preferredMaxLayoutWidth = 250
        moveDescription.textLabel.position = CGPoint(x: moveDescription.textLabel.position.x, y: -40)
        moveDescription.textLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        moveDescription.textLabel.numberOfLines = 4
        
        charName.position = CGPoint(x: 348, y: 175)
        charName.textLabel.fontName = "Helvetica"
        charName.textLabel.text = ""
        charName.textLabel.preferredMaxLayoutWidth = 107

        upperScrnArea.strokeColor = .clear
        gridScreenArea.strokeColor = .clear
        lowerScrnArea.strokeColor = .clear
        
        self.addChild(upperScrnArea)
        self.addChild(gridScreenArea)
        self.addChild(lowerScrnArea)
        self.upperScrnArea.addChild(settingsBtn)
        self.upperScrnArea.addChild(levelName)
        self.lowerScrnArea.addChild(endTurnBtn)
        self.lowerScrnArea.addChild(attackBtn)
        self.lowerScrnArea.addChild(spAttackBtn)
        self.lowerScrnArea.addChild(charName)
        self.lowerScrnArea.addChild(moveDescription)
        
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
    
    func updateCharName(name: String?) {
        self.charName.textLabel.text = name
    }
    
    func updateMoveDescription(moveDescription: String?) {
        self.moveDescription.textLabel.text = moveDescription
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
        fatalError("init(coder:) has not been implemented yet.")
    }
}
