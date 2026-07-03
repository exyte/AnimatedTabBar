//
//  ButtonsBarLayout.swift
//  
//
//  Created by Alisa Mylnikova on 26.01.2023.
//

import SwiftUI

let buttonsBarSpace = "ButtonsBarSpace"

struct ButtonsBar: Layout {

    typealias Cache = [CGSize]

    func makeCache(subviews: Subviews) -> [CGSize] { [] }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout [CGSize]) -> CGSize {
        cache = subviews.map { $0.sizeThatFits(.unspecified) }
        let height = cache.reduce(0) { max($0, $1.height) }

        return CGSize(width: proposal.width ?? 0, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout [CGSize]) {
        var pt = CGPoint(x: bounds.minX, y: bounds.minY)
        let widthDelta = bounds.width / CGFloat(subviews.count)

        for (v, idealViewSize) in zip(subviews, cache) {
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

    static let defaultValue: Value = []

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

