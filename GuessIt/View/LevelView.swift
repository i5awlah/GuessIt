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
    
    @State var attempts: Int = 0
    @State var presentAlert = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.linearGradient
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                navBar
                questionCard
                answers.disabled(questionViewModel.isWinLevel)
                
                
                if !questionViewModel.isLastLevel && questionViewModel.isWinLevel {
                    Spacer()
                    Button("Next Level") {
                        questionViewModel.gotoNextLevel()
                    }
                    .buttonStyle(OrangeButton())
                } else {
                    lettersGrid
                }
                
                if !questionViewModel.isWinLevel {
                    Button {
                        presentAlert.toggle()
                    } label: {
                        HStack {
                            Image("lightLamp")
                            Text("Hint")
                        }
                    }
                    .buttonStyle(OrangeButton())
                    .disabled(questionViewModel.coin < questionViewModel.coinsWhenHint)
                }
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
    var navBar: some View {
        Rectangle()
            .fill(Color.navbarColor)
            .frame(height: 104)
            .overlay(alignment: .bottom) {
                Text("LEVEL\(String(questionViewModel.levelNumber+1))")
                    .bold()
                    .font(.titleFont(for: questionViewModel.appLanguage))
                    .foregroundColor(.white)
                    .frame(height: 65)
                    .frame(maxWidth: .infinity)
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
    
    var questionCard: some View {
        VStack {
            Text("Guess the \(questionViewModel.questions[questionViewModel.levelNumber].questionType.rawValue.localized)")
                .foregroundColor(.white)
                .font(.questionFont(for: questionViewModel.appLanguage))
                .accessibility(sortPriority: 2)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 175)
                .overlay {
                    Text(questionViewModel.questions[questionViewModel.levelNumber].emojis)
                        .font(.system(size: 60))
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .padding(.horizontal, 5)
                        .accessibility(sortPriority: 1)
                        .accessibilityLabel(getEmojiLabel())
                }
                .padding(.horizontal, 16)
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint("Question")
    }
    
    var answers: some View {
        HStack {
            
            ForEach(0..<questionViewModel.questions[questionViewModel.levelNumber].answer.count, id: \.self) { i in
                RoundedRectangle(cornerRadius: 8)
                    .fill(questionViewModel.userAnswer.indices.contains(i) ? Color.lightGreen : Color.babyLavender)
                    .frame(width: 36, height: 36)
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
                            questionViewModel.userAnswer[i].isClicked = false
                            questionViewModel.userAnswer.remove(at: i)
                        }
                    }
            }
        }
        .modifier(Shake(animatableData: CGFloat(attempts)))
    }
    
    var lettersGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.fixed(63)),
                GridItem(.fixed(63)),
                GridItem(.fixed(63)),
                GridItem(.fixed(63)),
                GridItem(.fixed(63))
            ],
            spacing: 20) {
                ForEach(questionViewModel.randomLetter, id: \.id) { item in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("customGrey"))
                        .frame(height: 63)
                        .overlay {
                            Text(item.letter)
                                .font(.letterFont(for: questionViewModel.appLanguage))
                            .foregroundColor(.letterLavender)
                            .accessibilityAddTraits(.isButton)
                            .accessibilityHint("add letter to the answer")
                    }
                    .onTapGesture {
                        if questionViewModel.userAnswer.count < questionViewModel.questions[questionViewModel.levelNumber].answer.count {
                            handleAddingLetterToAnswer(item: item)
                        }
                    }
                    .opacity(item.isClicked ? 0 : 1)
            }
        }
    }
}

extension LevelView {
    
    
    func handleAddingLetterToAnswer(item: Letter) {
        item.isClicked = true
        questionViewModel.userAnswer.append(item)
        
        // check if user fill all letters
        if questionViewModel.userAnswer.count == questionViewModel.questions[questionViewModel.levelNumber].answer.count {
            
            var fullUserAnswer = ""
            questionViewModel.userAnswer.forEach({ fullUserAnswer += $0.letter })
            
            // check if user answer and quastion answer is sama
            if fullUserAnswer.lowercased() == questionViewModel.questions[questionViewModel.levelNumber].answer.lowercased() {
                handleCorrectAnswer()
            } else {
                handleWrongAnswer()
            }
        }
    }
    
    func handleCorrectAnswer() {
        SoundManager.shared.playSound(soundType: .successSound)
        print("Win!!")
        // to disable any click
        questionViewModel.isWinLevel = true
        // show Excellent view
        withAnimation(.easeIn) {
            questionViewModel.showWinView.toggle()
        }
        questionViewModel.increaseCoins()
        questionViewModel.checkIfLastLevel()
    }
    
    func handleWrongAnswer() {
        SoundManager.shared.playSound(soundType: .wrongSound)
        withAnimation(.default) {
            self.attempts += 1
            questionViewModel.userAnswer.removeAll()
            questionViewModel.randomLetter.forEach({ $0.isClicked = false })
        }
    }
    
    func getEmojiLabel() -> String {
        let letters = "ابتثحخدذرزسشصضطظعغفقكلمنهويءئؤةى"
        let count = letters.filter({ questionViewModel.questions[questionViewModel.levelNumber].emojis.contains(String($0))}).count
        if count == 0 && questionViewModel.appLanguage == "ar" {
            return String(questionViewModel.questions[questionViewModel.levelNumber].emojis.reversed())
        } else {
            return questionViewModel.questions[questionViewModel.levelNumber].emojis
        }
    }
}
