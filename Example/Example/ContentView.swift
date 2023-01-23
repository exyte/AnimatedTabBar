//
//  ContentView.swift
//  Example
//
//  Created by Alisa Mylnikova on 23.01.2023.
//

import SwiftUI
import AnimatedTabBar

struct ContentView: View {

    @State private var selectedIndex = 0

    @State var params: [CGFloat] = Array(repeating: 0, count: 5)

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.examplePurple.edgesIgnoringSafeArea(.all)

            AnimatedTabBar(selectedIndex: $selectedIndex) {
                DropletTab(imageName: "tab1", t: params[0])
                DropletTab(imageName: "tab2", t: params[1])
                DropletTab(imageName: "tab3", t: params[2])
                DropletTab(imageName: "tab4", t: params[3])
                DropletTab(imageName: "tab5", t: params[4])
            }
            .cornerRadius(16)
            .selectedColor(.exampleGrey.opacity(0.3))
            .unselectedColor(.exampleGrey.opacity(0.3))
            .ballColor(.white)
            .verticalPadding(15)
            .frame(maxWidth: .infinity)
            .padding(8)
        }
        .onAppear {
            params[0] = 1
        }
        .onChange(of: selectedIndex) { [selectedIndex] newValue in
            withAnimation(.linear(duration: 0.6).delay(0.3)) {
                params[newValue] = 1
            }
            params[selectedIndex] = 0
        }
    }
}

struct DropletTab: View, Animatable {

    var imageName: String
    var t: CGFloat

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    @State private var frame: CGRect = .zero

    private var scale: CGFloat {
        var t = t
        if t < 0.5 {
            t = t*2
        } else {
            t = (1 - t)*2
        }
        return 1 - 0.2 * t
    }

    var body: some View {
        ZStack {
            Image(imageName)
                .padding(.vertical, 10)
            Droplet(t: t)
                .mask(t > 0.2 ? AnyView(Image(imageName)) : AnyView(Rectangle().frame(width: frame.width, height: frame.height)))
                .foregroundColor(.examplePurple)
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

struct FrameGetter: ViewModifier {

    @Binding var frame: CGRect

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    DispatchQueue.main.async {
                        let rect = proxy.frame(in: .global)
                        // This avoids an infinite layout loop
                        if rect.integral != self.frame.integral {
                            self.frame = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
    }
}

extension View {
    public func frameGetter(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameGetter(frame: frame))
    }
}
