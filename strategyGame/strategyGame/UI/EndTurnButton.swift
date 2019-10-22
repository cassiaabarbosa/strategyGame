import SpriteKit

class EndTurnButton: Button {
    
    override init(rect: CGRect, text: String) {
        super.init(rect: rect, text: "End Turn")
    }
    
    override func press() {
        GameManager.shared.endTurn()
        self.pressed = true
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            self.pressed = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
