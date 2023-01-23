//
//  LevelView.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI



struct LevelView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    
    @State var presentAlert = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.linearGradient
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                CustomNavBar(title: "LEVEL", backLabel: "LEVELS", accessibilityLevelValue: "\(questionViewModel.selectedLevel+1)")
                Text("LEVEL")
                Text("\(questionViewModel.selectedLevel+1)")
                
                questionCard
                answers
                
                lettersGrid
                    HStack {
                        Button {
                            // haptic
                            HapticManager.instance.notification(type: .warning)
                            presentAlert.toggle()
                        } label: {
                            HStack {
                                Image("lightLamp")
                                Text("Hint")
                            }
                        }
                        .bold()
                        .font(.textInButtonFont(for: questionViewModel.appLanguage))
                        .foregroundColor (.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.customOrange)
                        .cornerRadius(16)
                        .frame(height: 44)
                        
                        Button {
                            // haptic
                            HapticManager.instance.notification(type: .warning)
                            questionViewModel.shareQuestion()
                        } label: {
                            HStack {
                                Text("Ask Friends")
                            }
                        }
                        .bold()
                        .font(.textInButtonFont(for: questionViewModel.appLanguage))
                        .foregroundColor (.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.customOrange)
                        .cornerRadius(16)
                        .frame(height: 44)
                    }
                    .frame(maxWidth: UIDevice.isIPad ? UIScreen.main.bounds.height * 0.6 - 35 : .infinity)
                    .padding(.horizontal, UIDevice.isIPad ? 0 : 16)

            }
            .edgesIgnoringSafeArea(.top)
            .disabled(presentAlert ? true : false)
            .accessibilityHidden(presentAlert || questionViewModel.showWinView ? true : false)
            
            if questionViewModel.showWinView {
                WinView(showWinView: $questionViewModel.showWinView)
            }
            
            if presentAlert {
                CustomAlert(presentAlert: $presentAlert)
            }
            
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
            .environmentObject(QuestionViewModel())
    }
}

extension LevelView {
    
    var questionCard: some View {
        VStack {
            Text("Guess the \(questionViewModel.questions[questionViewModel.selectedLevel].questionType.rawValue.localized)")
                .foregroundColor(.white)
                .font(.questionFont(for: questionViewModel.appLanguage))
                .accessibility(sortPriority: 2)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: UIScreen.main.bounds.height * 0.2)
                .frame(maxWidth: UIDevice.isIPad ? UIScreen.main.bounds.height * 0.6 - 35 : .infinity)
                .overlay {
                    Text(questionViewModel.questions[questionViewModel.selectedLevel].emojis)
                        .font(.system(size: 60))
                        .foregroundColor(.black)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .padding(.horizontal, 5)
                        .accessibility(sortPriority: 1)
                        .accessibilityLabel(questionViewModel.getEmojiLabel())
                }
                .padding(.horizontal, 16)
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint("Question")
    }
    
    var answers: some View {
        HStack {
            
            ForEach(0..<questionViewModel.questions[questionViewModel.selectedLevel].answer.count, id: \.self) { i in
                RoundedRectangle(cornerRadius: 8)
                    .fill(questionViewModel.userAnswer.indices.contains(i) ? Color.lightGreen : Color.babyLavender)
                    .frame(height: UIDevice.isIPad ? 96 : 36)
                    .frame(maxWidth: UIDevice.isIPad ? 96 : 36)
                    .overlay {
                        if questionViewModel.userAnswer.indices.contains(i) {
                            Text(questionViewModel.userAnswer[i].letter)
                                .font(.letterFont(for: questionViewModel.appLanguage))
                                .foregroundColor(Color.darkGreen)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityHint("delete letter from the answer")
                        }
                    }
                    .onTapGesture {
                        if questionViewModel.userAnswer.indices.contains(i) {
                            // haptic
                            HapticManager.instance.impact(style: .light)
                            questionViewModel.userAnswer[i].isClicked = false
                            questionViewModel.userAnswer.remove(at: i)
                        }
                    }
            }
        }
        .padding(.horizontal, 16)
        .modifier(Shake(animatableData: CGFloat(questionViewModel.attempts)))
    }
    
    var lettersGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.fixed(UIDevice.isIPad ? UIScreen.main.bounds.height * 0.12 - 15 : UIScreen.main.bounds.width * 0.2 - 15)),
                GridItem(.fixed(UIDevice.isIPad ? UIScreen.main.bounds.height * 0.12 - 15 : UIScreen.main.bounds.width * 0.2 - 15)),
                GridItem(.fixed(UIDevice.isIPad ? UIScreen.main.bounds.height * 0.12 - 15 : UIScreen.main.bounds.width * 0.2 - 15)),
                GridItem(.fixed(UIDevice.isIPad ? UIScreen.main.bounds.height * 0.12 - 15 : UIScreen.main.bounds.width * 0.2 - 15)),
                GridItem(.fixed(UIDevice.isIPad ? UIScreen.main.bounds.height * 0.12 - 15 : UIScreen.main.bounds.width * 0.2 - 15))
            ],
            spacing: 10) {
                ForEach(questionViewModel.randomLetter, id: \.id) { item in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("customGrey"))
                        .frame(height: UIDevice.isIPad ? UIScreen.main.bounds.height * 0.12 - 15 : UIScreen.main.bounds.width * 0.2 - 15)
                        .overlay {
                            Text(item.letter)
                                .font(.letterFont(for: questionViewModel.appLanguage))
                            .foregroundColor(.letterLavender)
                            .accessibilityAddTraits(.isButton)
                            .accessibilityHint("add letter to the answer")
                    }
                    .onTapGesture {
                        if questionViewModel.userAnswer.count < questionViewModel.questions[questionViewModel.selectedLevel].answer.count {
                            questionViewModel.handleAddingLetterToAnswer(item: item)
                        }
                    }
                    .opacity(item.isClicked ? 0 : 1)
            }
        }
    }
}
