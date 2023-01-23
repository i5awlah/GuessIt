//
//  CustomNavBar.swift
//  GuessIt
//
//  Created by Khawlah on 23/01/2023.
//

import SwiftUI

struct CustomNavBar: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    @Environment(\.dismiss) var dismiss
    
    let title: String
    let showLevelNumber: Bool
    let backLabel: String
    let showAccessibilityLevelValue: Bool
    
    var body: some View {
        Rectangle()
            .fill(Color.navbarColor)
            .frame(height: 104)
            .overlay(alignment: .bottom) {
                HStack(spacing: 0) {
                    Text(title.localized)
                    Text(showLevelNumber ? "\(questionViewModel.selectedLevel+1)" : "")
                }
                .bold()
                .font(.titleFont(for: questionViewModel.appLanguage))
                .foregroundColor(.white)
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(title)
                .accessibilityValue(
                    showAccessibilityLevelValue ?
                    "\(questionViewModel.selectedLevel+1)" : ""
                )
                .overlay(alignment: .leading) {
                    Circle()
                        .fill(Color("backYellow"))
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "arrow.backward")
                                .bold()
                                .font(.title3)
                                .foregroundColor(.white)
                                .accessibilityRemoveTraits(.isImage)
                        }
                        .onTapGesture {
                            // haptic
                            HapticManager.instance.impact(style: .light)
                            questionViewModel.userAnswer.removeAll()
                            dismiss()
                        }
                        .accessibilityLabel(backLabel)
                        .accessibilityHint("back button")
                }
                .overlay(alignment: .trailing) {
                    
                    HStack {
                        Image("coinimage")
                            .resizable()
                            .frame(width: 35, height: 35)
                        
                        Text("\(questionViewModel.coin)")
                            .font(.title3)
                            .foregroundColor(.babyYellow)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("coin")
                    .accessibilityValue("\(questionViewModel.coin)")
                    .environment(\.layoutDirection, .leftToRight)
                }
                .padding(.horizontal, 16)
                .offset(y: 2)
            }
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(Color("lineColor"))
                    .frame(height: 1)
            }
        
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(
            title: "LEVEL".localized,
            showLevelNumber: true,
            backLabel: "",
            showAccessibilityLevelValue: true
        )
        .environmentObject(QuestionViewModel())
    }
}
