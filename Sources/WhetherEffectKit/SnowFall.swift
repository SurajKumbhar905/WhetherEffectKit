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


class SnowFall : SKScene{
    private let intensity: Intensity
    
    init(intensity: Intensity) {
            self.intensity = intensity
            super.init(size: UIScreen.main.bounds.size)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        self.backgroundColor = .clear
        
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        if let emitterPath = Bundle.module.url(forResource: "SnowFall", withExtension: "sks") {
            print(emitterPath,"emitterPath")
            do {
                let fileData = try Data(contentsOf: emitterPath)
                let emitterNode = try NSKeyedUnarchiver.unarchivedObject(ofClass: SKEmitterNode.self, from: fileData)
                
                
                emitterNode?.particleBirthRate = birthRateForIntensity()
                
                let imageName = Bundle.module.url(forResource: "Ellipse1", withExtension: "png")
                let imageData = try Data(contentsOf: imageName!)
//                emitterNode?.particleTexture = SKTexture(image: UIImage(data: imageData)!)
//                emitterNode?.particleColor = UIColor.white
//                emitterNode?.particleTexture =  SKTexture(image: UIImage(data: imageData)!)
                addChild(emitterNode!)
              
                emitterNode?.particlePositionRange.dx = UIScreen.main.bounds.width

                
            } catch {
                print("didn't work")
            }
        }
        
       
        
    }
    
    override func didMove(to view: SKView) {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        self.backgroundColor = .clear
        
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        if let emitterPath = Bundle.module.url(forResource: "SnowFall", withExtension: "sks") {
            do {
                let fileData = try Data(contentsOf: emitterPath)
                let emitterNode = try NSKeyedUnarchiver.unarchivedObject(ofClass: SKEmitterNode.self, from: fileData)
                
                
                emitterNode?.particleBirthRate = birthRateForIntensity()
                addChild(emitterNode!)
                emitterNode?.particlePositionRange.dx = UIScreen.main.bounds.width

                
            } catch {
                print("didn't work")
            }
        }
        
    }
    
    private func birthRateForIntensity() -> CGFloat {
            switch intensity {
            case .light:
                return 40
            case .moderate:
                return 80
            case .heavy:
                return 120
            }
        }
    
    
}
