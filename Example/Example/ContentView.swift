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
    @State private var prevSelectedIndex = 0

    let names = ["heart", "leaf", "drop", "circle", "book"]

    // a hack for keyframe animation
    @State var time = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.examplePurple.edgesIgnoringSafeArea(.all)

            VStack(spacing: 50) {
                AnimatedTabBar(selectedIndex: $selectedIndex) {
                    colorButtonAt(0, type: .bell)
                    colorButtonAt(1, type: .bell)
                    colorButtonAt(2, type: .plus)
                    colorButtonAt(3, type: .calendar)
                    colorButtonAt(4, type: .gear)
                }
                .cornerRadius(16)
                .selectedColor(.exampleGrey)
                .unselectedColor(.exampleLightGrey)
                .ballColor(.white)
                .verticalPadding(20)
                .ballTrajectory(.straight)
                .ballAnimation(.interpolatingSpring(stiffness: 130, damping: 15))
                .indentAnimation(.easeOut(duration: 0.3))

                AnimatedTabBar(selectedIndex: $selectedIndex,
                               views: (0..<5).map { dropletButtonAt($0) })
                .cornerRadius(16)
                .selectedColor(.exampleGrey.opacity(0.3))
                .unselectedColor(.exampleGrey.opacity(0.3))
                .ballColor(.white)
                .verticalPadding(15)

                AnimatedTabBar(selectedIndex: $selectedIndex,
                               views: (0..<names.count).map { wiggleButtonAt($0, name: names[$0]) })
                .cornerRadius(16)
                .selectedColor(.examplePurple)
                .unselectedColor(.examplePurple.opacity(0.3))
                .ballColor(.white)
                .verticalPadding(28)
                .ballTrajectory(.teleport)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
        }
        .onChange(of: selectedIndex) { oldValue, _ in
            prevSelectedIndex = oldValue
        }
        // a hack for keyframe animation
        .onReceive(timer) { input in
            time = Date().timeIntervalSince1970
        }
    }

    func colorButtonAt(_ index: Int, type: ColorButton.AnimationType) -> some View {
        ColorButton(
            image: Image("colorTab\(index+1)"),
            colorImage: Image("colorTab\(index+1)Bg"),
            isSelected: selectedIndex == index,
            fromLeft: prevSelectedIndex < index,
            toLeft: selectedIndex < index,
            animationType: type)
    }

    func dropletButtonAt(_ index: Int) -> some View {
        DropletButton(imageName: "tab\(index+1)", dropletColor: .examplePurple, isSelected: selectedIndex == index)
    }

    func wiggleButtonAt(_ index: Int, name: String) -> some View {
        KeyframeWiggleButton(isSelected: index == selectedIndex, image: Image(systemName: name), maskImage: Image(systemName: "\(name).fill"))
            .scaleEffect(1.2)
    }
}
