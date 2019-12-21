import SpriteKit

class AttackButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "Attack")
        self.label.position = CGPoint(x: 0, y: -5)
    }
    
    override func press() {
        Button.unpressAll()
        
        GameManager.shared.onAttackButtonPress()
        self.pressed = true
    }
    
    override func unpress() {
        GameManager.shared.onAttackButtonUnpress()
        self.pressed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
