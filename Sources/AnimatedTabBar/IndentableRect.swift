//
//  IndentableRect.swift
//  
//
//  Created by Alisa Mylnikova on 24.01.2023.
//

import SwiftUI

struct IndentableRect: Shape {

    var t: CGFloat

    // when animating 0 -> 1: do nothing until delay, then animate quickly from delay to 1
    // when animating 1 -> 0: animate quickly 1 to delay, then do nothing from delay to 0
    var delay: CGFloat = 0

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
        let indentWidth = 60.0

        let indentPath = TranslatedPath(rect: CGRect(
            x: rect.midX - indentWidth/2,
            y: rect.minY,
            width: indentWidth,
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

struct TranslatedPath {

    // svg path
    // M 0 0
    // C 11.5 0 19.5 17 27.5 17
    // C 35.5 17 43.5 0 55 0

    let maxX = 55.0
    let maxY = 17.0

    let rect: CGRect

    func translate(x: CGFloat, y: CGFloat) -> CGPoint {
        CGPoint(x: x / maxX * rect.width + rect.minX, y: y / maxY * rect.height + rect.minY)
    }

    func path() -> Path {

        let t1 = translate(x: 0, y: 0)
        let t2 = translate(x: 27.5, y: 17)
        let t3 = translate(x: 55, y: 0)

        let c1 = translate(x: 11.5, y: 0)
        let c2 = translate(x: 19.5, y: 17)
        let c3 = translate(x: 35.5, y: 17)
        let c4 = translate(x: 43.5, y: 0)

        var path = Path()
        path.move(to: t1)
        path.addCurve(to: t2, control1: c1, control2: c2)
        path.addCurve(to: t3, control1: c3, control2: c4)
        return path
    }
}

struct SlidingIndentRect: Shape {

    var t: CGFloat

    var indentX: CGFloat
    var prevIndentX: CGFloat

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let tl = rect.origin
        let tr = CGPoint(x: rect.maxX, y: rect.minY)
        let bl = CGPoint(x: rect.minX, y: rect.maxY)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)

        let indentWidth = 60.0

        let indentPath = TranslatedPath(rect: CGRect(
            x: prevIndentX + (indentX - prevIndentX) * t - indentWidth/2,
            y: rect.minY,
            width: indentWidth,
            height: 15)
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
