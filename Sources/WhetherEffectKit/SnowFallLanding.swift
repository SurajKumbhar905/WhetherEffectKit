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


class SnowFallLanding : SKScene{
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill

        let height = UIScreen.main.bounds.height


        anchorPoint = CGPoint(x: 0.5, y: (height - 5) / height)

        backgroundColor = .clear
        if let emitterPath = Bundle.module.url(forResource: "SnowFallLanding", withExtension: "sks") {
            do {
                let fileData = try Data(contentsOf: emitterPath)
                let emitterNode = try NSKeyedUnarchiver.unarchivedObject(ofClass: SKEmitterNode.self, from: fileData)
                let imageName = Bundle.module.url(forResource: "spark", withExtension: "png")
                let imageData = try Data(contentsOf: imageName!)
                emitterNode?.particleTexture = SKTexture(image: UIImage(data: imageData)!)
                emitterNode?.position.y = self.frame.maxY
                addChild(emitterNode!)
                
                emitterNode?.particlePositionRange.dx = UIScreen.main.bounds.width - 30

                
            } catch {
                print("didn't work")
            }
        }
        

       
    }
}
