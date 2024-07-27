import SwiftUI
import SpriteKit

struct PlayGameView: View {
    
    var level: Int
    @State var levelForUse: Int!
    
    @State var playGameScene: PlayGameScene!
    @State var v = "g"
    
    var body: some View {
        ZStack {
            if let s = playGameScene {
                SpriteView(scene: s)
                               .ignoresSafeArea()
            }
            
            switch (v) {
            case "w":
                WinGameView(level: levelForUse)
            case "go":
                GameOverView()
            case "p":
                PauseGameView()
            default:
                EmptyView()
            }
        }
        .onAppear {
            print("level \(level)")
            levelForUse = level
            playGameScene = PlayGameScene(level: levelForUse)
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("close_pause")), perform: { _ in
            playGameScene.isPaused = false
            withAnimation {
                self.v = "g"
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("touched_all")), perform: { _ in
            print("level_saved \(levelForUse + 1)")
            UserDefaults.standard.set(levelForUse + 1, forKey: "last_level")
            withAnimation {
                self.v = "w"
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("not_touched_all")), perform: { _ in
            withAnimation {
                self.v = "go"
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("paused_game")), perform: { _ in
            withAnimation {
                self.v = "p"
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("restart_game")), perform: { notif in
            if let userInfo = notif.userInfo, let lastLevel = userInfo["level"] as? Int {
                self.levelForUse = lastLevel
                playGameScene = playGameScene.restartWithNeededLevel(level: lastLevel)
            }
            
            if notif.userInfo == nil {
                playGameScene = playGameScene.restartWithNeededLevel(level: levelForUse)
            }
            
            withAnimation {
                self.v = "g"
            }
        })
    }
}

#Preview {
    PlayGameView(level: 1)
}

class PlayGameScene: SKScene, SKPhysicsContactDelegate {
    
    private var level: Int
    
    var ball: SKSpriteNode!
    var arrow: SKSpriteNode!
    
    var obstaclesIdsTouched = [String]()
    
    func restartWithNeededLevel(level: Int) -> PlayGameScene {
        let newPlayScene = PlayGameScene(level: level)
        view?.presentScene(newPlayScene)
        return newPlayScene
    }
    
    private var maps: [Int: Map] = [
        1: MapLevel1(),
        2: MapLevel2(),
        3: MapLevel3(),
        4: MapLevel4(),
        5: MapLevel5(),
        6: MapLevel6(),
        7: MapLevel7(),
        8: MapLevel8(),
        9: MapLevel5(),
        10: MapLevel7()
    ]
    private var map: Map
    
    init(level: Int) {
        self.level = level
        self.map = maps[level]!
        super.init(size: CGSize(width: 750, height: 1335))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        addChild(createBackgroundImage())
        addChild(createLevelLabel())
        addChild(createRestartButton())
        addChild(createPausedButton())
        
        setUpBallWithArrow()
        
        map.drawMap(scene: self)
    }
    
    private func setUpBallWithArrow() {
        ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: 150, height: 140)
        ball.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2 + 100)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2 - 40)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.linearDamping = 0.0  // Устанавливаем низкое значение для уменьшения сопротивления
        ball.physicsBody?.angularDamping = 0.0
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.collisionBitMask = 2
        ball.physicsBody?.contactTestBitMask = 2
        ball.name = "ball"
        addChild(ball)
        
        arrow = SKSpriteNode(imageNamed: "arrow")
        arrow.position = CGPoint(x: size.width / 2 - 80, y: size.height / 2 + 180)
        arrow.size = CGSize(width: 150, height: 150)
        addChild(arrow)
    }
    
    private func createPausedButton() -> SKSpriteNode {
        let pausedButton = SKSpriteNode(imageNamed: "paused_game_b")
        pausedButton.position = CGPoint(x: 100, y: size.height - 150)
        pausedButton.size = CGSize(width: 120, height: 115)
        pausedButton.name = "pausedButton"
        return pausedButton
    }
    
    private func createRestartButton() -> SKSpriteNode {
        let restartButton = SKSpriteNode(imageNamed: "restart_b")
        restartButton.position = CGPoint(x: size.width - 100, y: size.height - 150)
        restartButton.size = CGSize(width: 120, height: 115)
        restartButton.name = "restartButton"
        return restartButton
    }
    
    private func createBackgroundImage() -> SKSpriteNode {
        let backImage = SKSpriteNode(imageNamed: "game_image")
        backImage.size = size
        backImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        return backImage
    }
    
    private func createLevelLabel() -> SKSpriteNode {
        let levelNode = SKSpriteNode()
        
        let levelBackground = SKSpriteNode(imageNamed: "level_bg")
        levelBackground.position = CGPoint(x: 0, y: 0)
        levelBackground.size = CGSize(width: 300, height: 120)
        levelNode.addChild(levelBackground)
        
        let levelLabel2 = SKLabelNode(text: "Level \(level)")
        levelLabel2.fontName = "MochiyPopOne-Regular"
        levelLabel2.fontColor = .white
        levelLabel2.fontSize = 44
        levelLabel2.position = CGPoint(x: 0.5, y: -14)
        levelNode.addChild(levelLabel2)
        
        let levelLabel = SKLabelNode(text: "Level \(level)")
        levelLabel.fontName = "MochiyPopOne-Regular"
        levelLabel.fontColor = UIColor.init(red: 1, green: 27/255, blue: 119/255, alpha: 1)
        levelLabel.fontSize = 42
        levelLabel.position = CGPoint(x: 0, y: -14)
        levelNode.addChild(levelLabel)
        
        levelNode.position = CGPoint(x: size.width / 2, y: size.height - 150)
        
        return levelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let atPoint = atPoint(touch.location(in: self))
            
            if atPoint.name == "pausedButton" {
                isPaused = true
                NotificationCenter.default.post(name: Notification.Name("paused_game"), object: nil)
            }
            
            if atPoint.name == "restartButton" {
                NotificationCenter.default.post(name: Notification.Name("restart_game"), object: nil)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let angle = atan2(location.y - ball.position.y, location.x - ball.position.x)
            ball.zRotation = angle + 30
            arrow.zRotation = angle + 30
            arrow.position = CGPoint(x: (ball.position.x) + cos(angle) * 50, y: (ball.position.y) + sin(angle) * 50)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let objectInPoint = atPoint(location)
            if objectInPoint.name != "pausedButton" {
                let dx = location.x - ball.position.x
                let dy = location.y - ball.position.y
                let vector = CGVector(dx: dx, dy: dy)
                ball.physicsBody?.applyImpulse(vector)
                arrow.run(SKAction.fadeOut(withDuration: 0.1))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 ||
            bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1 {
            let obstacle: SKPhysicsBody
            
            if bodyA.categoryBitMask == 1 {
                obstacle = contact.bodyB
            } else {
                obstacle = contact.bodyA
            }
            
            if let particle = SKEmitterNode(fileNamed: "Exp") {
                particle.position = ball.position
                addChild(particle)
                let wait = SKAction.wait(forDuration: 0.5)
                let remove = SKAction.removeFromParent()
                particle.run(SKAction.sequence([wait, remove]))
            }
            
            if let obstacleNode = obstacle.node, let obstacleName = obstacleNode.name {
                if !obstaclesIdsTouched.contains(obstacleName) {
                    obstaclesIdsTouched.append(obstacleName)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let maxSpeed: CGFloat = 1000.0
        if let velocity = ball.physicsBody?.velocity {
            let speed = sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy)
            if speed > maxSpeed {
                ball.physicsBody?.linearDamping = 0.1
            } else {
                ball.physicsBody?.linearDamping = 0.0
            }
        }
        
        if ball.position.x > size.width || ball.position.y < 0 || ball.position.y > size.height || ball.position.x < 0 {
            isPaused = true
            if obstaclesIdsTouched.count == map.obstaclesCount {
                NotificationCenter.default.post(name: Notification.Name("touched_all"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("not_touched_all"), object: nil)
            }
        }
    }
    
}
