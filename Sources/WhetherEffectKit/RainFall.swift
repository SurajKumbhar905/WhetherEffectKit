//
//  File.swift
//  WhetherEffectKit
//
//  Created by Suraj-KU on 20/02/25.
//

import Foundation
import SpriteKit
import SwiftUI
import UIKit


class RainFall : SKScene{
    
    var lastBranchNodePoint : CGPoint = CGPoint(x: 0, y: 1)
    private let intensity: Intensity
    
    
    
    init(intensity: Intensity) {
        self.intensity = intensity
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        
        backgroundColor = .clear
        
        let branchNode = (intensity == .moderate || intensity == .heavy)
        
        if let emitterPath = Bundle.module.url(forResource: "RainFall", withExtension: "sks") {
            do {
                let fileData = try Data(contentsOf: emitterPath)
                let emitterNode = try NSKeyedUnarchiver.unarchivedObject(ofClass: SKEmitterNode.self, from: fileData)
                let imageName = Bundle.module.url(forResource: "spark", withExtension: "png")
                let imageData = try Data(contentsOf: imageName!)
                emitterNode?.particleTexture = SKTexture(image: UIImage(data: imageData)!)
                emitterNode?.particleBirthRate = birthRateForIntensity()
                emitterNode?.position.y = self.frame.maxY
                addChild(emitterNode!)
                
                emitterNode?.particlePositionRange.dx = self.frame.width * 2.5

                
            } catch {
                print("didn't work")
            }
        }


       
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            DispatchQueue.main.async {
                let baseX = self.size.width / 3
                let variation = CGFloat.random(in: -100...100)
                let startPoint = CGPoint(x: baseX + variation, y: self.size.height)
                self.startLightning(for: startPoint,isBranchNode: branchNode)
                
                if branchNode{
                    let randomBlinkCounter = Int.random(in: 0...5)
                    self.boltFlasher(glowCount: randomBlinkCounter)
                }
                
            }
            
        }
    }
    
    private func addBolt(currentPoint: CGPoint, latestPoint: CGPoint) {
        let boltPath = CGMutablePath()
        boltPath.move(to: currentPoint)
        boltPath.addLine(to: latestPoint)
        
        let bolt = SKShapeNode()
        bolt.name = "bolt"
        bolt.path = boltPath
        bolt.glowWidth = 1
        bolt.strokeColor = .white
        bolt.glowWidth = 2
        
        
        addChild(bolt)
    }
    
    
    private func generateRandomBoltPoints(with currentPoints: CGPoint) -> CGPoint {
        let randomBoltLength = Double.random(in: 5..<30)
        let randomAngle = Double.random(in: -180..<180)
        let x = randomBoltLength * cos(randomAngle) + currentPoints.x
        let y = currentPoints.y - abs(randomBoltLength * sin(randomAngle))
        
        return CGPoint(x: x, y: y)
    }
    
    private func startLightning(for currentPoint: CGPoint, isBranchNode: Bool = false, currentIteration: Int = 1) {
        var latestPoint = generateRandomBoltPoints(with: currentPoint)
        let randomedBranchNode = Int.random(in: 0...100)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0..<0.03)) {
            if currentIteration % 11 == 0 {
                self.lightningFlasher(flashCount: 1)
            }
            if isBranchNode && currentPoint.y >= 0 {
                self.addBolt(currentPoint: currentPoint, latestPoint: latestPoint)
                self.startLightning(for: latestPoint, isBranchNode: true, currentIteration: currentIteration + 1)
            } else {
                if self.lastBranchNodePoint.y >= 0 {
                    let isBranchNode = currentIteration == randomedBranchNode
                    latestPoint = self.generateRandomBoltPoints(with: self.lastBranchNodePoint)
                    self.addBolt(currentPoint: self.lastBranchNodePoint, latestPoint: latestPoint)
                    self.lastBranchNodePoint = latestPoint
                    self.startLightning(for: latestPoint, isBranchNode: isBranchNode, currentIteration: currentIteration + 1)
                }else{
                    self.removeBolts()
                }
            }
        }
        
        self.backgroundColor = .clear
        self.alpha = 1.0
    }
    
    private func removeBolts() {
        self.enumerateChildNodes(withName: "bolt") { node, _ in
            node.removeFromParent()
            self.backgroundColor = .clear
            self.alpha = 1.0
        }
    }
    
    private func boltFlasher(glowCount: Int = 0) {
        let unglowBolt: SKAction = SKAction.run { () -> Void in
            self.alpha = 0.5
        }
        
        let glowBolt: SKAction = SKAction.run { () -> Void in
            self.alpha = 1.0
        }
        
        let waitAction: SKAction = SKAction.wait(forDuration: 0.2)
        
        run(SKAction.repeat(SKAction.sequence([unglowBolt,
                                               waitAction,
                                               glowBolt,
                                               waitAction]), count: glowCount))
    }
    
    
    private func lightningFlasher(flashCount: Int = 0) {
        let whiteFlash: SKAction = SKAction.run { () -> Void in
            self.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        }
        
        let darkFlash: SKAction = SKAction.run { () -> Void in
            self.backgroundColor = .black
        }
        
        let waitAction: SKAction = SKAction.wait(forDuration: 0.05)
        
        run(SKAction.repeat(SKAction.sequence([whiteFlash,
                                               waitAction,
                                               darkFlash,
                                               waitAction]), count: flashCount))
    }
    
    private func birthRateForIntensity() -> CGFloat {
        switch intensity {
        case .light:
            return 750
        case .moderate:
            return 1500
        case .heavy:
            return 3000
        }
    }
    
}

