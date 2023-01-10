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
    @State var showWinView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.linearGradient
                .ignoresSafeArea()
            
            VStack(spacing: 36) {
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
            }
            .edgesIgnoringSafeArea(.top)
            
            
            WinView {
                withAnimation(.easeIn) {
                    showWinView.toggle()
                }
                questionViewModel.gotoNextLevel()
            } quitAction: {
                withAnimation(.easeIn) {
                    showWinView.toggle()
                }
            }
            .scaleEffect(showWinView ? 1 : 0)
            .opacity(showWinView ? 1 : 0)
            
            
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
                            }
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    .overlay(alignment: .trailing) {
                        HStack(spacing: 0) {
                            Image("goldenCoin")
                                .resizable()
                                .frame(width: 65, height: 65)
                            
                            Text("\(questionViewModel.coin)")
                                .font(.title3)
                                .foregroundColor(.babyYellow)
                                .padding(.leading, -10)
                        }
                        .padding(.leading, -10)
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
                }
                .padding(.horizontal, 16)
        }
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
            showWinView.toggle()
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
}
