//
//  ContentView.swift
//  Example
//
//  Created by Alisa Mylnikova on 23.01.2023.
//

import SwiftUI
import AnimatedTabBar

struct ContentView: View {
    let greyColor = Color(hex: "0C0C0C")
    let purpleColor = Color(hex: "7D26FE")

    @State private var selectedIndex = 0

    @State var t: CGFloat = 1

    var body: some View {
        ZStack(alignment: .bottom) {
            purpleColor.edgesIgnoringSafeArea(.all)
            AnimatedTabBar(selectedIndex: $selectedIndex) {
                Heart(t: t)
                Image(systemName: "sun.max")
                Image(systemName: "sun.min.fill")
            }
            .cornerRadius(16)
            .selectedColor(.black)
            .unselectedColor(greyColor.opacity(0.3))
            .ballColor(.white)
            .frame(maxWidth: .infinity)
            .padding(8)
        }
        .onChange(of: selectedIndex) { newValue in
            if newValue == 0 {
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 10)) {
                    t = 1
                }
            } else {
                t = 0
            }
        }
    }
}

struct Heart: View {

    var t: CGFloat

    var body: some View {
        ZStack {
            HeartBg(t: t)
                .opacity(0.4)
                .mask(Image(systemName: "heart.fill"))
            Image(systemName: "heart")
        }
    }
}

struct HeartBg: Shape {

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
