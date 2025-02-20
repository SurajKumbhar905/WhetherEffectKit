//
//  File.swift
//  WhetherEffectKit
//
//  Created by Suraj-KU on 20/02/25.
//

import Foundation

import Foundation
import SpriteKit
import SwiftUI
import UIKit


class RainFallLanding : SKScene{
    
    
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
        
        let height = UIScreen.main.bounds.height
        
        anchorPoint = CGPoint(x: 0.5, y: (height - 5) / height)
        
        backgroundColor = .clear
        
        if let emitterPath = Bundle.module.url(forResource: "RainFallLanding", withExtension: "sks") {
            do {
                let fileData = try Data(contentsOf: emitterPath)
                let emitterNode = try NSKeyedUnarchiver.unarchivedObject(ofClass: SKEmitterNode.self, from: fileData)
                let imageName = Bundle.module.url(forResource: "spark", withExtension: "png")
                let imageData = try Data(contentsOf: imageName!)
                emitterNode?.particleTexture = SKTexture(image: UIImage(data: imageData)!)
                emitterNode?.particleBirthRate = birthRateForIntensity()
                emitterNode?.position.y = self.frame.maxY
                addChild(emitterNode!)
                
                emitterNode?.particlePositionRange.dx = UIScreen.main.bounds.width - 30

                
            } catch {
                print("didn't work")
            }
        }
    }
    
    
    private func birthRateForIntensity() -> CGFloat {
        switch intensity {
        case .light:
            return 200
        case .moderate:
            return 400
        case .heavy:
            return 3000
        }
    }
   
}
