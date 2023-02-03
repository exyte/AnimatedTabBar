//
//  SwiftUIView.swift
//  
//
//  Created by Alisa Mylnikova on 24.01.2023.
//

import SwiftUI

public struct DropletButton: View {

    public var imageName: String
    public var dropletColor: Color
    public var isSelected: Bool

    public init(imageName: String, dropletColor: Color, isSelected: Bool) {
        self.imageName = imageName
        self.dropletColor = dropletColor
        self.isSelected = isSelected
    }

    @State var t: CGFloat = 0

    public var body: some View {
        DropletButtonAnimatable(imageName: imageName, dropletColor: dropletColor, t: t)
            .onChange(of: isSelected) { newValue in
                if newValue {
                    withAnimation(.linear(duration: 0.9)) {
                        t = 1
                    }
                } else {
                    t = 0
                }
            }
            .onAppear {
                if isSelected {
                    t = 1
                }
            }
    }
}

struct DropletButtonAnimatable: View, Animatable {

    var imageName: String
    var dropletColor: Color
    var t: CGFloat

    public init(imageName: String, dropletColor: Color, t: CGFloat) {
        self.imageName = imageName
        self.dropletColor = dropletColor
        self.t = t
    }

    public var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    @State private var frame: CGRect = .zero

    private var scale: CGFloat {
        var t = t
        if t < 0.3 { // 0...0.3 -> 0...1
            t = t*3.33
        } else { // 0.3...0.6 -> 1...0; 0.6...1 -> 0
            t = max((0.6 - t) * 3.33, 0)
        }
        return 1 - 0.2 * t
    }

    private var dropletParam: CGFloat {
        if t < 0.3 {
            return 0
        } else {
            return (t - 0.3) * 1/0.7
        }
    }

    public var body: some View {
        ZStack {
            Image(imageName)
                .padding(.vertical, 10)
            Droplet(t: dropletParam)
                .mask(t > 0.5 ? AnyView(Image(imageName)) : AnyView(Rectangle().frame(width: frame.width, height: frame.height)))
                .foregroundColor(dropletColor)
        }
        .scaleEffect(scale)
        .frameGetter($frame)
    }
}

struct Droplet: Shape {

    var t: CGFloat

    func path(in rect: CGRect) -> Path {
        let param = t * 20
        let inset = min(t * 5, 1) * 15

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY + inset), radius: param, startAngle: Angle(radians: 0), endAngle: Angle(radians: 2 * .pi), clockwise: false)
        return path
    }
}
