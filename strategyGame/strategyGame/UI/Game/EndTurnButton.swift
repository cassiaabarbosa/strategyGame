import SpriteKit

class EndTurnButton: Button {
    
    override init(rect: CGRect, text: String, action: @escaping () -> Void) {
        super.init(rect: rect, text: "End", action: action)
        self.buttonNormalTex = SKTexture(imageNamed: "SquareButton")
        self.buttonPressedTex = SKTexture(imageNamed: "SquareButtonPressed")
        self.texture = buttonNormalTex
        self.label.position = CGPoint(x: 0, y: -10)
        self.label.fontSize = self.label.text!.count < 10 ? 17*(rect.size.height/39) : 5*(rect.size.height/39)
    }
    
    override func press() {
        GameManager.shared.onEndTurnButtonPress()
        
        self.pressed = true
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            self.pressed = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
