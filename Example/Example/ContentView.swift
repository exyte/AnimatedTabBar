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

    let names = ["heart", "leaf", "drop", "circle"]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.examplePurple.edgesIgnoringSafeArea(.all)

            VStack {
                AnimatedTabBar(selectedIndex: $selectedIndex,
                               views: (0..<names.count).map { buttonAt($0, name: names[$0]) })
                .cornerRadius(16)
                .selectedColor(.examplePurple)
                .unselectedColor(.examplePurple.opacity(0.3))
                .ballColor(.white)
                .verticalPadding(30)
                .frame(maxWidth: .infinity)
                .padding(8)
                
                AnimatedTabBar(selectedIndex: $selectedIndex,
                               views: (0..<5).map { dropletButtonAt($0) })
                .cornerRadius(16)
                .selectedColor(.exampleGrey.opacity(0.3))
                .unselectedColor(.exampleGrey.opacity(0.3))
                .ballColor(.white)
                .verticalPadding(15)
                .frame(maxWidth: .infinity)
                .padding(8)
            }
        }
    }

    func buttonAt(_ index: Int, name: String) -> some View {
        WiggleButton(image: Image(systemName: name), maskImage: Image(systemName: "\(name).fill"), isSelected: selectedIndex == index)
            .scaleEffect(1.3)
    }

    func dropletButtonAt(_ index: Int) -> some View {
        DropletButtonInterpolator(imageName: "tab\(index+1)", dropletColor: .examplePurple, isSelected: selectedIndex == index)
            .id(index)
    }
}
