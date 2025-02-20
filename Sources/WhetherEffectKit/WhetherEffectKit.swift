// The Swift Programming Language
// https://docs.swift.org/swift-book



import SwiftUI
import SpriteKit

public enum EffectType {
    case rain
    case snow
    case rainLanding
    case snowLanding
}

public enum Intensity {
    case light
    case moderate
    case heavy
}

@available(iOS 13.0, *)
public struct WeatherEffectView: UIViewRepresentable {
    
    private let effectType: EffectType
    private let intensity: Intensity
    
    public init(effectType: EffectType, intensity: Intensity) {
        self.effectType = effectType
        self.intensity = intensity
    }
    
    public func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.backgroundColor = .clear
        return skView
    }
    
    public func updateUIView(_ uiView: SKView, context: Context) {
        let scene: SKScene
        switch effectType {
        case .rain:
            scene = RainFall(intensity: intensity)
        case .snow:
            scene = SnowFall(intensity: intensity)
        case .rainLanding:
            scene = RainFallLanding(intensity: intensity)
        case .snowLanding:
            scene = SnowFallLanding()
        }
        
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        uiView.presentScene(scene)
    }
}
