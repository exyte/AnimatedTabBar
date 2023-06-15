//
//  GeometryEffect.swift
//  
//
//  Created by Alisa Mylnikova on 24.01.2023.
//

import SwiftUI

struct AlongPath: GeometryEffect {

    var t: CGFloat
    var trajectory: Path

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        if let point = trajectory.point(at: t) {
            return ProjectionTransform(CGAffineTransform(translationX: point.x, y: point.y))
        }
        return ProjectionTransform()
    }
}

extension View {
    public func alongPath(t: CGFloat, trajectory: Path) -> some View {
        self.modifier(AlongPath(t: t, trajectory: trajectory))
    }
}

struct TeleportEffect: GeometryEffect {

    var t: CGFloat
    var from: CGFloat
    var to: CGFloat
    
    // fraction of full animation time in which animation should happen
    var fraction: CGFloat = 0.2

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    var scale: CGFloat {
        if t < fraction { // 0...0.1 -> 1...0
            return 1 - t*1/fraction
        }
        if t > 1 - fraction { // 0.9...1 -> 0...1
            return (t - (1-fraction)) * 1/fraction
        }
        return -5000
    }

    var anchor: CGFloat {
        t < 0.5 ? t*2 : (1-t)*2
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: t < 0.5 ? from : to, y: 0)
            .translatedBy(x: size.width * anchor, y: size.height * anchor)
            .scaledBy(x: scale, y: scale))
    }
}

extension View {
    public func teleportEffect(t: CGFloat, from: CGFloat, to: CGFloat) -> some View {
        self.modifier(TeleportEffect(t: t, from: from, to: to))
    }
}
