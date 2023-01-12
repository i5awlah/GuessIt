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
    
    static let darkOrange = Color("darkOrange")
    static let lightOrange = Color("lightOrange")
    
    
    
    static let linearGradient = LinearGradient(colors: [.darkLavender, .lightLavender], startPoint: .top, endPoint: .bottom)
    static let yellowLinearGradient = LinearGradient(colors: [.darkYellow, .lightYellow], startPoint: .top, endPoint: .bottom)
    static let orangeLinearGradient = LinearGradient(colors: [.darkOrange, .lightOrange], startPoint: .bottom, endPoint: .top)
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
      }
}

extension Font {
    static func questionFont(for language: String) -> Font {
        switch language {
        case "ar":
            return .custom("SF Arabic", size: 30)
        default:
            return .custom("Arial", size: 30)
        }
    }
    
    static func titleFont(for language: String) -> Font {
        switch language {
        case "ar":
            return .custom("SF Arabic", size: 26)
        default:
            return .custom("Arial Narrow", size: 26)
        }
    }
    
    static func letterFont(for language: String) -> Font {
        switch language {
        case "ar":
            return .custom("Geeza Pro", size: 32)
        default:
            return .custom("Helvetica", size: 32)
        }
    }
    
    static func textInButtonFont(for language: String) -> Font {
        switch language {
        case "ar":
            return .custom("Geeza Pro", size: 21)
        default:
            return .custom("Arial", size: 25)
        }
    }
    
    static func textInShortButtonFont(for language: String) -> Font {
        switch language {
        case "ar":
            return .custom("Geeza Pro", size: 22)
        default:
            return .custom("Arial", size: 22)
        }
    }
}

// .font(.custom("", size: 32))
// .font(.custom("Geeza Pro", size: ))

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
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
