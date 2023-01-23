//
//  ContentView.swift
//  asd
//
//  Created by Alisa Mylnikova on 05/10/2020.
//

import SwiftUI

private let buttonsBarSpace = "ButtonsBarSpace"

public struct AnimatedTabBar: View {

    @Binding private var selectedIndex: Int
    private var animation: Animation

    private let views: [AnyView]

    public init<Views>(selectedIndex: Binding<Int>,
                animation: Animation = .easeOut(duration: 0.6),
                @ViewBuilder content: @escaping () -> TupleView<Views>) {
        self._selectedIndex = selectedIndex
        self.animation = animation
        self.views = content().getViews
    }

    private var barColor: Color = .white
    private var selectedColor: Color = .red
    private var unselectedColor: Color = .black
    private var ballColor: Color = .red

    private var verticalPadding: CGFloat = 30
    private var cornerRadius: CGFloat = 0

    @State private var prevSelectedIndex = 0
    @State private var frames: [CGRect] = []
    @State private var t: CGFloat = 0

    private let circleSize = 10.0

    public var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Circle()
                    .frame(width: circleSize, height: circleSize)
                    .foregroundColor(ballColor)
                    .fixedSize()
                    //.offset(x: (coords[safe: selectedIndex]?.midX ?? 0) - circleSize/2)
                    .alongPath(
                        t: t,
                        trajectory: trajectory(
                            from: getCoord(prevSelectedIndex),
                            to: getCoord(selectedIndex)
                        )
                    )
                Spacer()
            }
            .padding(.top, 100)

            ZStack {
                HStack(spacing: 0) {
                    ForEach(0..<views.count, id: \.self) { i in
                        IndentableRect(t: selectedIndex == i ? 1 : 0, delay: 0.7)
                            .foregroundColor(barColor)
                            .animation(animation, value: selectedIndex)
                    }
                }
                .cornerRadius(cornerRadius)

                ButtonsBar {
                    ForEach(0..<views.count, id: \.self) { i in
                        views[i].onTapGesture {
                            withAnimation(animation) {
                                selectedIndex = i
                            }
                        }
                        .foregroundColor(selectedIndex == i ? selectedColor : unselectedColor)
                        .offset(y: selectedIndex == i ? -8 : 0)
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
            t = 0
            DispatchQueue.main.async {
                withAnimation(animation) {
                    t = 1
                }
            }
        }
    }

    func getCoord(_ at: Int) -> CGPoint {
        guard let frame = frames[safe: at] else {
            return .zero
        }
        return CGPoint(x: frame.midX - circleSize/2, y: frame.minY + 15)
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

    // MARK: - Customization

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
}

struct IndentableRect: Shape {

    var t: CGFloat

    // when animating 0 -> 1: do nothing until delay, then animate quickly from delay to 1
    // when animating 1 -> 0: animate quickly 1 to delay, then do nothing from delay to 0
    var delay: CGFloat

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var t = t
        if t < delay {
            t = 0
        } else {
            t = (t - delay) * 1/(1-delay)
        }

        let tl = rect.origin
        let tr = CGPoint(x: rect.maxX, y: rect.minY)
        let bl = CGPoint(x: rect.minX, y: rect.maxY)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)

        let yCurve = t * 15

        let indentPath = NormalizedPath(rect: CGRect(
            x: rect.minX + 3.5/12 * rect.width,
            y: rect.minY,
            width: 5/12 * rect.width,
            height: yCurve)
        ).path()

        var path = Path()
        path.move(to: tl)
        path.addPath(indentPath)
        path.addLine(to: tr)
        path.addLine(to: br)
        path.addLine(to: bl)
        path.addLine(to: tl)
        return path
    }
}

struct NormalizedPath {

    // svg path
    // M 0 0
    // C 11.5 0 19.5 17 27.5 17
    // C 35.5 17 43.5 0 55 0

    let maxX = 55.0
    let maxY = 17.0

    let rect: CGRect

    func normalize(x: CGFloat, y: CGFloat) -> CGPoint {
        CGPoint(x: x / maxX * rect.width + rect.minX, y: y / maxY * rect.height + rect.minY)
    }

    func path() -> Path {

        let t1 = normalize(x: 0, y: 0)
        let t2 = normalize(x: 27.5, y: 17)
        let t3 = normalize(x: 55, y: 0)

        let c1 = normalize(x: 11.5, y: 0)
        let c2 = normalize(x: 19.5, y: 17)
        let c3 = normalize(x: 35.5, y: 17)
        let c4 = normalize(x: 43.5, y: 0)

        var path = Path()
        path.move(to: t1)
        path.addCurve(to: t2, control1: c1, control2: c2)
        path.addCurve(to: t3, control1: c3, control2: c4)
        return path
    }
}

extension View {
    public func alongPath(t: CGFloat, trajectory: Path) -> some View {
        self.modifier(AlongPath(t: t, trajectory: trajectory))
    }
}

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

struct ButtonsBar: Layout {

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let idealViewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let height = idealViewSizes.reduce(0) { max($0, $1.height) }

        return CGSize(width: proposal.width ?? 0, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var pt = CGPoint(x: bounds.minX, y: bounds.minY)
        let widthDelta = bounds.width / CGFloat(subviews.count)

        for v in subviews {
            let idealViewSize = v.sizeThatFits(.unspecified)
            let x = pt.x + widthDelta/2 - idealViewSize.width/2
            let y = bounds.midY - idealViewSize.height/2
            let point = CGPoint(x: x, y: y)

            v.place(at: point, anchor: .topLeading, proposal: .unspecified)

            pt.x += widthDelta
        }
    }
}

struct ButtonPreferenceKey: PreferenceKey {
    typealias Value = [CGRect]

    static var defaultValue: Value = []

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct ButtonPreferenceViewSetter: View {

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: ButtonPreferenceKey.self,
                            value: [geometry.frame(in: .named(buttonsBarSpace))])
        }
    }
}
