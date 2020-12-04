import SpriteKit

class EndTurnButton: Button {
    
    init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "End", action: { GameManager.shared.onEndTurnButtonPress() })
        self.buttonNormalTex = SKTexture(imageNamed: "SquareButton")
        self.buttonPressedTex = SKTexture(imageNamed: "SquareButtonPressed")
        self.texture = buttonNormalTex
        self.label.position = CGPoint(x: 0, y: -10)
        self.label.fontSize = self.label.text!.count < 10 ? 17*(rect.size.height/39) : 5*(rect.size.height/39)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
