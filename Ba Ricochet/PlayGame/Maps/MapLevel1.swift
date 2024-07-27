
import SwiftUI
import SpriteKit

class MapLevel1: Map {
    
    var obstaclesCount: Int = 2
    
    func drawMap(scene: PlayGameScene) {
        let lineRicoshet1 = createLine(size: CGSize(width: 50, height: 350), rotation: 45)
        let lineRicoshet2 = createLine(size: CGSize(width: 50, height: 350), rotation: 45)
        let size = scene.size
        
        lineRicoshet1.position = CGPoint(x: size.width / 2 + 200, y: size.height / 2 + 250)
        lineRicoshet2.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2 - 250)
        lineRicoshet1.name = "line_1"
        lineRicoshet2.name = "line_2"
        scene.addChild(lineRicoshet1)
        scene.addChild(lineRicoshet2)
        
    }
    
}
