//
//  AlongPath.swift
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
