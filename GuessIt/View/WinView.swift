//
//  WinView.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

struct WinView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    let nextAction: () -> Void
    let quitAction: () -> Void
    
    var body: some View {
        ZStack {
            
            Color.navbarColor
                .opacity(0.94)
                .ignoresSafeArea()
            
            Image("bg_sunburst")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 34) {
                    Text("Excellent!")
                        .bold()
                        .font(.custom("Arial", size: 55))
                        .foregroundColor (Color.customOrange)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.5 ,height: 130)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.customOrange)
                                .frame(width: 210 ,height: 132)
                                .mask(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke((Color.white), lineWidth: 3)
                                )
                                .shadow(color: Color.customOrange ,radius: 3, y: 1)
                                .overlay {
                                    VStack {
                                        Text(questionViewModel.questions[questionViewModel.levelNumber].emojis)
                                            .font(.system(size: 72))
                                                .scaledToFit()
                                                .minimumScaleFactor(0.01)
                                                .lineLimit(1)
                                                .padding(.horizontal, 5)
                                        Text(questionViewModel.questions[questionViewModel.levelNumber].answer)
                                            .font(.custom("Arial", size: 30))
                                            .foregroundColor(Color.customOrange)
                                    }
                                }
                        }
                }
                .padding(.top, 71)
                .padding(.bottom, 26)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.yellowLinearGradient)
                        .overlay(alignment: .top) {
                            Circle()
                                .fill(Color.orangeLinearGradient)
                                .frame(width: 96, height: 96)
                                .overlay {
                                    Image(systemName: "checkmark")
                                        .foregroundColor (.white)
                                        .font(.system(size: 60))
                                }
                                .overlay(alignment: .bottomTrailing, content: {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.coinYellow)
                                        .frame(width: 80, height: 32)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.customOrange)
                                                .frame(width: 80, height: 32)
                                            .mask(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke((Color.white), lineWidth: 3)
                                            )
                                            .overlay {
                                                HStack(spacing: 0) {
                                                    Image("goldenCoin")
                                                        .resizable()
                                                        .frame(width: 36, height: 36)
                                                        .offset(x: 4)
                                                    Text("+\(questionViewModel.coinsWhenWin)")
                                                        .foregroundColor(Color.customOrange)
                                                        .fontWeight(.semibold)
                                                        .font(.system(size: 19))
                                                }
                                                .offset(x: -4)
                                                .environment(\.layoutDirection, .leftToRight)
                                            }
                                        }
                                        .offset(x: 35)
                                })
                                .offset(y: -48)
                        }
                }
                .padding(.horizontal, 16)
                
                VStack {
                    if !questionViewModel.isLastLevel {
                        Button("Next Level") {
                            nextAction()
                        }
                        .buttonStyle(OrangeButton())
                    }
                    
                    Button("Quit") {
                        quitAction()
                    }
                    .buttonStyle(OrangeButton())
                }
                
                
            }
        }
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView(
            nextAction: {},
            quitAction: {}
        )
        .environmentObject(QuestionViewModel())
    }
}
