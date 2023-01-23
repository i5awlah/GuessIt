//
//  WinView.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

struct WinView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    @Binding var showWinView: Bool
    @State var isAppear = false
    
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
                .accessibilityHidden(true)
            
            VStack {
                
                VStack(spacing: 34) {
                    Text("Excellent!")
                        .bold()
                        .font(.custom("Arial", size: 55))
                        .foregroundColor (Color.customOrange)
                        .accessibility(sortPriority: 0)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.5 ,height: 130)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.customOrange)
                                .frame(width: UIScreen.main.bounds.width * 0.5 ,height: 130)
                                .mask(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke((Color.white), lineWidth: 3)
                                )
                                .shadow(color: Color.customOrange ,radius: 3, y: 1)
                                .overlay {
                                    VStack {
                                        Text(questionViewModel.questions[questionViewModel.selectedLevel].emojis)
                                            .font(.system(size: 72))
                                            .foregroundColor(.black)
                                                .scaledToFit()
                                                .minimumScaleFactor(0.01)
                                                .lineLimit(1)
                                                .padding(.horizontal, 16)
                                                .accessibilityHint("Question")
                                                .accessibility(sortPriority: 1)
                                        Text(questionViewModel.questions[questionViewModel.selectedLevel].fullAnswer)
                                            .font(.custom("Arial", size: 30))
                                            .foregroundColor(Color.customOrange)
                                            .accessibilityHint("Question answer")
                                            .accessibility(sortPriority: 2)
                                    }
                                }
                        }
                }
                .padding(.top, 71)
                .padding(.bottom, 26)
                .frame(maxWidth: UIDevice.isIPad ? UIScreen.main.bounds.width * 0.5 + 64 : .infinity)
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
                                        .accessibilityHidden(true)
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
                                                        .accessibilityLabel("coin")
                                                    Text("+\(questionViewModel.coinsWhenWin)")
                                                        .foregroundColor(Color.customOrange)
                                                        .fontWeight(.semibold)
                                                        .font(.system(size: 19))
                                                        .accessibilityHint("coin")
                                                }
                                                .offset(x: -4)
                                                .environment(\.layoutDirection, .leftToRight)
                                            }
                                        }
                                        .offset(x: 35)
                                        .opacity(
                                            questionViewModel.selectedLevel == questionViewModel.levelNumber ?
                                            1 : 0
                                        )
                                })
                                .offset(y: -48)
                                .environment(\.layoutDirection, .leftToRight)
                        }
                }
                .padding(.horizontal, 16)
                
                VStack {
                    if !questionViewModel.isLastLevel {
                        Button("Next Level") {
                            // haptic
                            HapticManager.instance.impact(style: .light)
                            withAnimation(.easeIn) {
                                showWinView.toggle()
                                isAppear.toggle()
                            }
                            questionViewModel.gotoNextLevel()
                        }
                        .buttonStyle(OrangeButton())
                        .accessibility(sortPriority: 3)
                    }
                    
                    Button("Quit") {
                        // haptic
                        HapticManager.instance.impact(style: .light)
                        withAnimation(.easeIn) {
                            showWinView.toggle()
                            isAppear.toggle()
                        }
                        questionViewModel.gotoNextLevel()
                    }
                    .accessibility(sortPriority: 4)
                    .buttonStyle(OrangeButton())
                }
                
                
            }
            .accessibilityElement(children: .contain)
        }
        .scaleEffect(isAppear ? 1 : 0)
        .opacity(isAppear ? 1 : 0)
        .onAppear{
            withAnimation(.easeIn) {
                isAppear = true
            }
        }
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView(showWinView: .constant(false))
        .environmentObject(QuestionViewModel())
    }
}
