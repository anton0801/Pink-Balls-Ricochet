import Foundation
import SpriteKit

protocol Map {
    var obstaclesCount: Int {
        get
        set
    }
    
    func drawMap(scene: PlayGameScene)
}

extension Map {
    func createLine(size: CGSize, rotation: CGFloat? = nil) -> SKSpriteNode {
        let lineRect = SKSpriteNode(imageNamed: "rect_line")
        lineRect.size = size
        lineRect.physicsBody = SKPhysicsBody(rectangleOf: lineRect.size)
        lineRect.physicsBody?.isDynamic = false
        lineRect.physicsBody?.affectedByGravity = false
        lineRect.physicsBody?.categoryBitMask = 2
        lineRect.physicsBody?.collisionBitMask = 1
        lineRect.physicsBody?.contactTestBitMask = 1
        lineRect.name = "ricosheter"
        if let rotation = rotation {
            lineRect.zRotation = rotation
        }
        return lineRect
    }
}
