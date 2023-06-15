//
//  File.swift
//
//
//  Created by Alisa Mylnikova on 14.06.2023.
//

import SwiftUI

struct AnimationValues {
    var scale = 1.0
    var bgWiggle = 0.0
}

public struct KeyframeWiggleButton: View {

    public var isSelected: Bool
    public var image: Image
    public var maskImage: Image

    @State var growTrigger = false
    @State var trigger = false

    public var body: some View {
        image
            .keyframeAnimator(initialValue: AnimationValues(), trigger: growTrigger) { content, value in
                ZStack {
                    KeyframeWiggleButtonBg(t: value.bgWiggle)
                        .opacity(0.4)
                        .mask(maskImage)
                    content
                }
                .scaleEffect(value.scale)
            } keyframes: { _ in
                KeyframeTrack(\.scale) {
                    CubicKeyframe(1.2, duration: 0.05)
                    CubicKeyframe(1.3, duration: 0.1)
                    CubicKeyframe(1.2, duration: 0.1)
                }

                KeyframeTrack(\.bgWiggle) {
                    SpringKeyframe(0.0, duration: 0.1)
                    SpringKeyframe(2.0, duration: 0.1)
                    SpringKeyframe(0.0, duration: 0.1)
                    SpringKeyframe(1.0, duration: 0.1)
                    SpringKeyframe(0.0, duration: 0.1)
                }
            }
            .onChange(of: isSelected) { oldValue, newValue in
                if newValue {
                    growTrigger.toggle()
                }
            }
    }
}

struct KeyframeWiggleButtonBg: Shape {

    var t: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: 10 + t, startAngle: Angle(radians: 0), endAngle: Angle(radians: .pi), clockwise: true)
        return path
    }
}
