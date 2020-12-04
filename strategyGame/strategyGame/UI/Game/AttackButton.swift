import SpriteKit

class AttackButton: Button {
    
    init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "Attack",
                   action: {
                    Button.unpressAll()
                    GameManager.shared.onAttackButtonPress()
                   },
                   unToggle: {
                    GameManager.shared.onAttackButtonUnpress()
                   })
        self.label.position = CGPoint(x: 0, y: -5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
