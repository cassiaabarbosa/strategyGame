import SpriteKit

class Background: SKNode {
    
    var shape: SKShapeNode
    var shader: SKShader
    
    init(view: UIView) {
        self.shader = SKShader(fileNamed: "BackgroundShader.fsh")
        self.shape = SKShapeNode(rect: view.frame)
        self.shape.fillShader = shader
        super.init()
        self.zPosition = -100
        addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
