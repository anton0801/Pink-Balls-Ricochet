import Foundation

class MapLevel2: Map {
    
    var obstaclesCount: Int = 2
    
    func drawMap(scene: PlayGameScene) {
        let lineRicoshet1 = createLine(size: CGSize(width: 50, height: 350))
        let lineRicoshet2 = createLine(size: CGSize(width: 50, height: 350))
        let size = scene.size
        
        lineRicoshet1.position = CGPoint(x: size.width / 2 + 250, y: size.height / 2 + 100)
        lineRicoshet2.position = CGPoint(x: size.width / 2 - 150, y: size.height / 2 - 100)
        lineRicoshet1.name = "line_1"
        lineRicoshet2.name = "line_2"
        scene.addChild(lineRicoshet1)
        scene.addChild(lineRicoshet2)
        
    }
    
}
