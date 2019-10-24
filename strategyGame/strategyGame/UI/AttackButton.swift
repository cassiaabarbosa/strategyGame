import SpriteKit

class AttackButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "Attack")
    }
    
    override func press() {
        Button.unpressAll()
        
        GameManager.shared.OnAttackButtonPress()
        self.pressed = true
    }
    
    override func unpress() {
        GameManager.shared.OnAttackButtonUnpress()
        self.pressed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
