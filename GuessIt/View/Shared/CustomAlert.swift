//
//  CustomAlert.swift
//  GuessIt
//
//  Created by Khawlah on 11/01/2023.
//

import SwiftUI

struct CustomAlert: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    @Binding var presentAlert: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            VStack(spacing: 32) {
                
                if questionViewModel.coin < questionViewModel.coinsWhenHint {
                    Text("You do not have enough coins")
                        .font(.custom("Arial", size: 26))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .accessibilitySortPriority(0)
                    
                    Button {
                        // haptic
                        HapticManager.instance.impact(style: .light)
                        presentAlert = false
                    } label: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.customOrange)
                            .frame(width: 112, height: 44)
                            .overlay {
                                Text("Cancel")
                                    .font(.textInShortButtonFont(for: questionViewModel.appLanguage))
                                    .foregroundColor (.navbarColor)
                            }
                    }
                    .accessibilitySortPriority(2)
                } else {
                    Text("Do you want a hint for".localized + " \(questionViewModel.coinsWhenHint) " + "coins?".localized)
                        .font(.custom("Arial", size: 26))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .accessibilitySortPriority(0)
                    
                    HStack(spacing: 16) {
                        
                        Button {
                            // haptic
                            HapticManager.instance.impact(style: .light)
                            questionViewModel.useHint()
                            presentAlert = false
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.customOrange)
                                .frame(width: 112, height: 44)
                                .overlay {
                                    Text("Yes")
                                        .font(.textInShortButtonFont(for: questionViewModel.appLanguage))
                                        .foregroundColor (.navbarColor)
                                }
                        }
                        .accessibilitySortPriority(2)
                        
                        Button {
                            // haptic
                            HapticManager.instance.impact(style: .light)
                            presentAlert = false
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.customOrange)
                                .frame(width: 112, height: 44)
                                .mask {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke((Color.white), lineWidth: 3)
                                }
                                .overlay {
                                    Text("No")
                                        .font(.textInShortButtonFont(for: questionViewModel.appLanguage))
                                        .foregroundColor(.customOrange)
                                }
                        }
                        .accessibilitySortPriority(1)

                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 32)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("alertLavender").opacity(0.74))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("alertLavender").opacity(0.74))
                            .blur(radius: 20)
                    })
            )
            .padding(.horizontal, 48)
            .accessibilityElement(children: .contain)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LevelView()
            CustomAlert(
                presentAlert: .constant(true)
            )
            
        }.environmentObject(QuestionViewModel())
    }
}
