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
                
                Text("Do you want a hint for".localized + " \(questionViewModel.coinsWhenHint) " + "coins?".localized)
                    .font(.custom("Arial", size: 26))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 16) {
                    
                    Button {
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
                    
                    Button {
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