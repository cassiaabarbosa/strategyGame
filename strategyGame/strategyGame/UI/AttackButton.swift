import SpriteKit

class AttackButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "Attack")
    }
    
    override func press() {
        Button.unpressAll()
        
        if self.pressed {
            GameManager.shared.mode = .move
            self.pressed = false
        } else {
            GameManager.shared.mode = .attack
            self.pressed = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
