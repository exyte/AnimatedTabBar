//
//  ExampleButtons.swift
//  
//
//  Created by Alisa Mylnikova on 27.01.2023.
//

import SwiftUI

public struct ColorButton: View {

    public enum AnimationType {
        case bell
        case plus
        case calendar
        case gear
    }

    public var image: Image
    public var colorImage: Image
    public var isSelected: Bool
    public var fromLeft: Bool
    public var toLeft: Bool
    public var animationType: AnimationType

    @State var t: CGFloat = 0
    @State var tForBg: CGFloat = 0

    var scale: CGFloat {
        1 + t * 0.2
    }

    public var body: some View {
        ZStack {
            ColorButtonBg(colorImage: colorImage, fromLeft: fromLeft, toLeft: toLeft, t: tForBg)
                .offset(x: 3, y: 3)
            switch animationType {
            case .bell:
                ColorButtonOutlineBell(image: image, t: t)
            case .plus:
                ColorButtonOutlinePlus(image: image, t: t)
            case .calendar:
                ColorButtonOutlineCalendar(image: image, fromLeft: fromLeft, t: t)
            case .gear:
                ColorButtonOutlineGear(image: image, t: t)
            }
        }
        .padding(8)
        .onAppear {
            if isSelected {
                tForBg = 1
            }
        }
        .onChange(of: isSelected) { newValue in
            if newValue {
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 10).delay(0.15)) {
                    t = 1
                }
                withAnimation(.easeIn(duration: 0.3)) {
                    tForBg = 1
                }
            } else {
                t = 0
                withAnimation(.easeIn(duration: 0.3)) {
                    tForBg = 0
                }
            }
        }
    }
}

struct ColorButtonOutlineBell: View, Animatable {

    var image: Image
    var t: CGFloat

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    var angle: CGFloat {
        if t < 0.5 {
            return 2*t * 20
        }
        return 2*(1 - t) * 20
    }

    var body: some View {
        image
            .rotationEffect(Angle(degrees: angle), anchor: UnitPoint(x: 0.5, y: 0))
    }
}

struct ColorButtonOutlinePlus: View {

    var image: Image
    var t: CGFloat

    var body: some View {
        ZStack {
            image
            Image("colorTab3Plus")
                .rotationEffect(Angle(degrees: t * 90))
        }
    }
}

struct ColorButtonOutlineCalendar: View, Animatable {

    var image: Image
    var fromLeft: Bool
    var t: CGFloat

    var animatableData: CGFloat {
        get { t }
        set { t = newValue }
    }

    var body: some View {
        ZStack {
            image
                .offset(x: offset(maxValue: 5))
            Circle()
                .frame(width: 3)
                .offset(x: 3, y: 4)
                .offset(x: offset(maxValue: 8))
        }
    }

    func offset(maxValue: CGFloat) -> CGFloat {
        let max = fromLeft ? maxValue : -maxValue
        if t < 0.5 {
            return 2*t * max
        }
        return 2*(1 - t) * max
    }
}

struct ColorButtonOutlineGear: View {

    var image: Image
    var t: CGFloat

    var body: some View {
        image
            .rotationEffect(Angle(degrees: t * 50))
    }
}

struct ColorButtonBg: View {

    var colorImage: Image
    var fromLeft: Bool
    var toLeft: Bool
    var t: CGFloat

    var offset: CGFloat {
        if t == 0 {
            return toLeft ? (t - 1) * 20 : (t - 1) * -15
        } else {
            return fromLeft ? (t - 1) * 20 : (t - 1) * -20
        }
    }

    var body: some View {
        colorImage
            .scaleEffect(t)
            .offset(x: offset)
    }
}

