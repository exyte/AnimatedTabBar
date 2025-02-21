//
//  File.swift
//
//
//  Created by Alisa Mylnikova on 14.06.2023.
//

import SwiftUI

struct AnimationValues {
    var growingScale = 1.0
    var shrinkingScale = 1.3
    var bgWiggle = 0.0
}

#if swift(>=5.9)
@available(iOS 17.0, *)
public struct KeyframeWiggleButton: View {

    public var image: Image
    public var maskImage: Image
    public var isSelected: Bool

    @State private var isGrowing = true

    public var body: some View {
        image
            .keyframeAnimator(initialValue: AnimationValues(), trigger: isSelected) { [isGrowing] content, value  in
                ZStack {
                    KeyframeWiggleButtonBg(t: isGrowing ? value.bgWiggle : 0)
                        .opacity(0.4)
                        .mask(maskImage)
                    content
                }
                .scaleEffect(isGrowing ? value.growingScale : value.shrinkingScale)
            } keyframes: { _ in
                KeyframeTrack(\.growingScale) {
                    CubicKeyframe(1.3, duration: 0.1)
                    CubicKeyframe(1.4, duration: 0.1)
                    CubicKeyframe(1.3, duration: 0.1)
                }

                KeyframeTrack(\.bgWiggle) {
                    SpringKeyframe(0.0, duration: 0.05)
                    SpringKeyframe(3.0, duration: 0.1)
                    SpringKeyframe(1.0, duration: 0.1)
                    SpringKeyframe(2.0, duration: 0.1)
                    SpringKeyframe(0.0, duration: 0.1)
                }

                KeyframeTrack(\.shrinkingScale) {
                    SpringKeyframe(0.9, duration: 0.2)
                }
            }
            .onChange(of: isSelected) { oldValue, newValue in
                isGrowing = newValue
            }
            .onAppear {
                isGrowing = !isSelected
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


#endif
