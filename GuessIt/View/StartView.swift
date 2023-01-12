//
//  StartView.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    @State private var goPlay = false
    @State private var showTextAlert = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.linearGradient
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIDevice.isIPad ? UIScreen.main.bounds.width * 0.5 + 64 : .infinity)
                        .accessibilityLabel("app logo")
                    
                    Spacer()
                    
                    Button {
                        if questionViewModel.isLastLevel {
                            withAnimation {
                                showTextAlert = true
                            }
                            withAnimation(Animation.linear.delay(2)) {
                                showTextAlert = false
                            }
                        } else {
                            // haptic
                            HapticManager.instance.impact(style: .light)
                            goPlay = true
                        }
                        
                    } label: {
                        RoundedRectangle (cornerRadius: 16)
                            .fill(Color("backYellow"))
                            .frame(height: 48)
                            .frame(maxWidth: UIDevice.isIPad ? UIScreen.main.bounds.width * 0.5 + 64 : .infinity)
                            .overlay {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text ("Play")
                                }
                                .bold()
                                .font(.system(size: 25))
                                .foregroundColor (.white)
                            }
                            .padding(.horizontal, 32)
                    }
                    .accessibility(sortPriority: 10)
                    .disabled(UIAccessibility.isVoiceOverRunning && questionViewModel.isLastLevel ? true : false)
                    .accessibilityHint(UIAccessibility.isVoiceOverRunning && questionViewModel.isLastLevel ? "You have completed all levels" : "")
                    
                    Text("You have completed all levels")
                        .bold()
                        .foregroundColor(.black)
                        .padding(5)
                        .background(Color.darkLavender.opacity(0.5))
                        .offset(y: showTextAlert ? 0 : -30)
                        .opacity(showTextAlert ? 1 : 0)

                    
                    Spacer()
                }
                .padding(.horizontal, 48)
                .accessibilityElement(children: .contain)
                
            }
            .navigationDestination(isPresented: $goPlay) {
                LevelView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    struct StartView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
                .environmentObject(QuestionViewModel())
        }
    }
}
