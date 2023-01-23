//
//  StartView.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    @State private var goLevelsView = false
    
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
                        // haptic
                        HapticManager.instance.impact(style: .light)
                        goLevelsView = true
                        
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
                    
                    Spacer()
                }
                .padding(.horizontal, 48)
                .accessibilityElement(children: .contain)
                
            }
            .navigationDestination(isPresented: $goLevelsView) {
                LevelsView()
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
