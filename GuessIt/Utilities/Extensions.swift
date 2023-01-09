//
//  Extensions.swift
//  GuessIt
//
//  Created by Khawlah on 08/01/2023.
//

import SwiftUI

extension Color {
    static let customOrange = Color("customOrange")
    static let darkGreen = Color("darkGreen")
    static let lightGreen = Color("lightGreen")
    
    static let babyLavender = Color("babyLavender")
    static let darkLavender = Color("darkLavender")
    static let letterLavender = Color("letterLavender")
    static let lightLavender = Color("lightLavender")
    static let navbarColor = Color("navbarColor")
    
    static let babyYellow = Color("babyYellow")
    static let coinYellow = Color("coinYellow")
    static let darkYellow = Color("darkYellow")
    static let lightYellow = Color("lightYellow")
    
    static let linearGradient = LinearGradient(colors: [.darkLavender, .lightLavender], startPoint: .top, endPoint: .bottom)
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
