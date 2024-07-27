import Foundation

class MapLevel5: Map {
    
    var obstaclesCount: Int = 3
    
    func drawMap(scene: PlayGameScene) {
        let lineRicoshet1 = createLine(size: CGSize(width: 50, height: 350))
        let lineRicoshet2 = createLine(size: CGSize(width: 50, height: 350))
        let lineRicoshet3 = createLine(size: CGSize(width: 50, height: 350), rotation: -45)
        let size = scene.size
        
        lineRicoshet1.position = CGPoint(x: size.width / 2 + 300, y: size.height / 2 + 150)
        lineRicoshet2.position = CGPoint(x: size.width / 2 - 200, y: size.height / 2 - 120)
        lineRicoshet3.position = CGPoint(x: size.width / 2, y: size.height / 2 - 300)
        lineRicoshet1.name = "line_1"
        lineRicoshet2.name = "line_2"
        lineRicoshet3.name = "line_3"
        scene.addChild(lineRicoshet1)
        scene.addChild(lineRicoshet2)
        scene.addChild(lineRicoshet3)
        
    }
    
}
