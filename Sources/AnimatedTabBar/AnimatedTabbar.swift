//
//  ContentView.swift
//  asd
//
//  Created by Alisa Mylnikova on 05/10/2020.
//

import SwiftUI

public struct AnimatedTabBar: View {

    public enum BallTrajectory {
        case parabolic
        case straight
    }

    @Binding private var selectedIndex: Int
    private let views: [AnyView]

    public init<Views>(selectedIndex: Binding<Int>,
                @ViewBuilder content: @escaping () -> TupleView<Views>) {
        self._selectedIndex = selectedIndex
        self.views = content().getViews
    }

    public init<Content: View>(selectedIndex: Binding<Int>,
                               views: [Content]) {
        self._selectedIndex = selectedIndex
        self.views = views.map { AnyView($0) }
    }

    // MARK: - Customization

    private var barColor: Color = .white
    private var selectedColor: Color = .red
    private var unselectedColor: Color = .black
    private var ballColor: Color = .red

    private var verticalPadding: CGFloat = 30
    private var cornerRadius: CGFloat = 0

    private var ballAnimation: Animation = .easeOut(duration: 0.6)
    private var indentAnimation: Animation = .easeOut(duration: 0.6)
    private var buttonsAnimation: Animation = .easeOut(duration: 0.6)
    private var ballTrajectory: BallTrajectory = .parabolic

    // MARK: - Properties

    @State private var prevSelectedIndex = 0
    @State private var frames: [CGRect] = []
    @State private var tBall: CGFloat = 0
    @State private var tIndent: CGFloat = 0

    private let circleSize = 10.0

    public var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                circle
                Spacer()
            }

            ZStack {
                background
                    .cornerRadius(cornerRadius)

                ButtonsBar {
                    ForEach(0..<views.count, id: \.self) { i in
                        views[i].onTapGesture {
                            selectedIndex = i
                        }
                        .foregroundColor(selectedIndex == i ? selectedColor : unselectedColor)
                        .animation(buttonsAnimation, value: selectedIndex)
                        .background(ButtonPreferenceViewSetter())
                    }
                }
                .coordinateSpace(name: buttonsBarSpace)
                .onPreferenceChange(ButtonPreferenceKey.self) { frames in
                    self.frames = frames
                }
                .padding(.vertical, verticalPadding)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .onChange(of: selectedIndex) { [selectedIndex] newValue in
            prevSelectedIndex = selectedIndex
            tBall = 0
            tIndent = 0
            DispatchQueue.main.async {
                withAnimation(ballAnimation) {
                    tBall = 1
                }
                withAnimation(indentAnimation) {
                    tIndent = 1
                }
            }
        }
    }

    @ViewBuilder
    var circle: some View {
        switch ballTrajectory {
        case .parabolic:
            Circle()
                .frame(width: circleSize, height: circleSize)
                .foregroundColor(ballColor)
                .fixedSize()
                .alongPath(
                    t: tBall,
                    trajectory: trajectory(
                        from: getBallCoord(prevSelectedIndex),
                        to: getBallCoord(selectedIndex)
                    )
                )

        case .straight:
            Circle()
                .frame(width: circleSize, height: circleSize)
                .foregroundColor(ballColor)
                .fixedSize()
                .offset(x: getBallCoord(selectedIndex).x, y: 15)
                .animation(ballAnimation, value: selectedIndex)
        }
    }

    @ViewBuilder
    var background: some View {
        switch ballTrajectory {
        case .parabolic:
            HStack(spacing: 0) {
                ForEach(0..<views.count, id: \.self) { i in
                    IndentableRect(t: selectedIndex == i ? 1 : 0, delay: 0.7)
                        .foregroundColor(barColor)
                        .animation(indentAnimation, value: selectedIndex)
                }
            }

        case .straight:
            SlidingIndentRect(t: tIndent, indentX: getCoord(selectedIndex).x, prevIndentX: getCoord(prevSelectedIndex).x)
                .foregroundColor(barColor)
        }
    }

    func getBallCoord(_ at: Int) -> CGPoint {
        guard let frame = frames[safe: at] else {
            return .zero
        }
        return CGPoint(x: frame.midX - circleSize/2, y: frame.minY + 15)
    }

    func getCoord(_ at: Int) -> CGPoint {
        guard let frame = frames[safe: at] else {
            return .zero
        }
        return CGPoint(x: frame.midX, y: frame.minY)
    }

    func trajectory(from: CGPoint?, to: CGPoint?) -> Path {
        var path = Path()
        guard let from = from, let to = to else {
            return path
        }
        path.move(to: from)
        path.addQuadCurve(to: to, control: CGPoint(x: (from.x + to.x)/2, y: from.y - 100))
        return path
    }

    // MARK: - Customization setters

    public func barColor(_ color: Color) -> AnimatedTabBar {
        var switcher = self
        switcher.barColor = color
        return switcher
    }

    public func selectedColor(_ color: Color) -> AnimatedTabBar {
        var switcher = self
        switcher.selectedColor = color
        return switcher
    }

    public func unselectedColor(_ color: Color) -> AnimatedTabBar {
        var switcher = self
        switcher.unselectedColor = color
        return switcher
    }

    public func ballColor(_ color: Color) -> AnimatedTabBar {
        var switcher = self
        switcher.ballColor = color
        return switcher
    }

    public func verticalPadding(_ verticalPadding: CGFloat) -> AnimatedTabBar {
        var switcher = self
        switcher.verticalPadding = verticalPadding
        return switcher
    }

    public func cornerRadius(_ cornerRadius: CGFloat) -> AnimatedTabBar {
        var switcher = self
        switcher.cornerRadius = cornerRadius
        return switcher
    }

    public func ballAnimation(_ ballAnimation: Animation) -> AnimatedTabBar {
        var switcher = self
        switcher.ballAnimation = ballAnimation
        return switcher
    }

    public func indentAnimation(_ indentAnimation: Animation) -> AnimatedTabBar {
        var switcher = self
        switcher.indentAnimation = indentAnimation
        return switcher
    }

    public func buttonsAnimation(_ buttonsAnimation: Animation) -> AnimatedTabBar {
        var switcher = self
        switcher.buttonsAnimation = buttonsAnimation
        return switcher
    }

    public func ballTrajectory(_ ballTrajectory: BallTrajectory) -> AnimatedTabBar {
        var switcher = self
        switcher.ballTrajectory = ballTrajectory
        return switcher
    }
}
