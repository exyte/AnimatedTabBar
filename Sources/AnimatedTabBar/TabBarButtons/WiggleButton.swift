//
//  SwiftUIView.swift
//  
//
//  Created by Alisa Mylnikova on 24.01.2023.
//

import SwiftUI

public struct WiggleButton: View {

    public var image: Image
    public var maskImage: Image
    public var isSelected: Bool

    public init(image: Image, maskImage: Image, isSelected: Bool) {
        self.image = image
        self.maskImage = maskImage
        self.isSelected = isSelected
    }

    @State var t: CGFloat = 0
    @State var tForBg: CGFloat = 0

    var scale: CGFloat {
        1 + t * 0.2
    }

    public var body: some View {
        ZStack {
            WiggleButtonBg(t: tForBg)
                .opacity(0.4)
                .mask(maskImage)
            image
        }
        .scaleEffect(scale)
        .onChange(of: isSelected) { newValue in
            if newValue {
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 5)) {
                    tForBg = 1
                }
                withAnimation {
                    t = 1
                }
            } else {
                tForBg = 0
                withAnimation {
                    t = 0
                }
            }
        }
        .onAppear {
            if isSelected {
                t = 1
            }
        }
    }
}

struct WiggleButtonBg: Shape {

    var t: CGFloat

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var t = t
        if t < 0.5 {
            t = t*2
        } else {
            t = (1 - t)*2
        }

        let param = t * 2
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: 10 + param, startAngle: Angle(radians: 0), endAngle: Angle(radians: .pi), clockwise: true)
        return path
    }
}

