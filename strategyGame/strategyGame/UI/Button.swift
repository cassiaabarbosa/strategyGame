import SpriteKit

let buttonScale = 1.6

class Button: SKSpriteNode {
    
    static var buttonList: [Button] = []
    
    public var buttonNormalTex = SKTexture(imageNamed: "button")
    public var buttonPressedTex = SKTexture(imageNamed: "ButtonPressed")
    public var pressedColor: UIColor = UIColor(hue: 0, saturation: 0.6, brightness: 0.5, alpha: 1)
    public var label: SKLabelNode
    public var action: () -> Void
    
    public internal(set) var pressed: Bool {
        didSet {
            self.texture = pressed ? buttonPressedTex : buttonNormalTex
            self.label.fontColor = #colorLiteral(red: 0.2803396583, green: 0.2141204476, blue: 0.1477846205, alpha: 1)
            
        }
    }
    
    private var touch: UITouch?
    
    init(rect: CGRect, text: String, action: @escaping () -> Void) {
        self.label = SKLabelNode(text: text)
        self.pressed = false
        self.action = action
        super.init(texture: buttonNormalTex, color: .white, size: rect.size)
        self.isUserInteractionEnabled = true
        self.position = CGPoint(x: rect.maxX - rect.width/2, y: rect.maxY - rect.height/2)
        self.label.position = CGPoint(x: 0, y: -10)
        self.label.fontSize = self.label.text!.count < 10 ? 23*(rect.size.height/39) : 17.5*(rect.size.height/39)
        self.label.fontColor = #colorLiteral(red: 0.2803396583, green: 0.2141204476, blue: 0.1477846205, alpha: 1)
        self.label.zPosition = 1.0
        self.label.fontName = "Copperplate-Bold"
        addChild(label)
        Button.buttonList.append(self)
    }
    
    deinit {
        for i in (0..<Button.buttonList.count) where self === Button.buttonList[i] {
            Button.buttonList.remove(at: i)
        }
    }
    
    func press() {}
    
    func unpress() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first
        pressed = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touch, let parent = self.parent else { return }
        if self.contains(touch.location(in: parent)) {
            action()
        }
        pressed = false
    }
    
    static func unpressAll() {
        for i in (0..<Button.buttonList.count) {
            Button.buttonList[i].pressed = false
        }
        GameManager.shared.onAttackButtonUnpress()
        GameManager.shared.onSpecialAttackButtonUnpress()
    }
    
    static func showAll() {
        for i in (0..<Button.buttonList.count) {
            Button.buttonList[i].isHidden = false
        }
    }
    
    static func hideAll() {
        for i in (0..<Button.buttonList.count) {
            Button.buttonList[i].isHidden = true
        }
    }
    
    static func hideAttackButtons() {
        for i in (0..<Button.buttonList.count) where (Button.buttonList[i] is AttackButton || Button.buttonList[i] is SpecialAttackButton) {
            Button.buttonList[i].isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
