//
//  LevelsView.swift
//  GuessIt
//
//  Created by Khawlah on 21/01/2023.
//

import SwiftUI

struct LevelsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.linearGradient
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                navBar
                levelsList
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LevelsView()
                .environmentObject(QuestionViewModel())
        }
    }
}

extension LevelsView {
    
    var navBar: some View {
        Rectangle()
            .fill(Color.navbarColor)
            .frame(height: 104)
            .overlay(alignment: .bottom) {
                Text("LEVELS")
                .bold()
                .font(.titleFont(for: questionViewModel.appLanguage))
                .foregroundColor(.white)
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .accessibilityLabel("LEVELS")
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
                            dismiss()
                        }
                        .accessibilityLabel("Start Page")
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
    
    var levelsList: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 160), spacing: 16)
                ],
                spacing: 16) {
                    ForEach(1...questionViewModel.questions.count, id: \.self) { i in

                        Button {
                            questionViewModel.selectedLevel = i-1
                            questionViewModel.getRandomLetter()
                            questionViewModel.goLevel.toggle()
                        } label: {
                            LevelCell(i: i)
                        }
                        .disabled(i-1 > questionViewModel.levelNumber ? true: false)
                        .navigationDestination(isPresented: $questionViewModel.goLevel) {
                            LevelView()
                                .navigationBarBackButtonHidden(true)
                        }
                    }
                }
                .padding(.horizontal, 16)
        }
    }
}
