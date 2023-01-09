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
    
    @State private var userAnswer: [Letter] = []
    @State var attempts: Int = 0
        
    var body: some View {
        ZStack(alignment: .top) {
            Color.linearGradient
                .ignoresSafeArea()
            VStack(spacing: 36) {
                navBar
                questionCard
                answers
                lettersGrid
            }
            .edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            questionViewModel.getRandomLetter()
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
            .frame(height: 98)
            .overlay(alignment: .bottom) {
                Text("LEVEL\(questionViewModel.levelNumber)")
                    .bold()
                    .font(.custom("Arial Narrow", size: 26))
                    .foregroundColor(.white)
                    .frame(height: 65)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(Color("backYellow"))
                            .frame(width: 36, height: 36)
                            .overlay {
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.callout)
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
                            Text(String(questionViewModel.coin))
                                .font(.title3)
                                .foregroundColor(.babyYellow)
                                .padding(.leading, -10)
                        }
                    }
                    .padding(.horizontal, 16)
                    .offset(y: 5)
            }
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(Color("lineColor"))
                    .frame(height: 1)
            }
        
    }
    
    var questionCard: some View {
        VStack {
            Text("Guess the \(questionViewModel.questions[questionViewModel.levelNumber - 1].questionType.rawValue)")
                .foregroundColor(.white)
                .font(.custom("Arial", size: 30))
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 175)
                .padding(.horizontal, 16)
                .overlay {
                    Text(questionViewModel.questions[questionViewModel.levelNumber - 1].emojis)
                        .font(.system(size: 60))
                }
        }
    }
    
    var answers: some View {
        HStack {
            
            ForEach(0..<questionViewModel.questions[questionViewModel.levelNumber - 1].answer.count, id: \.self) { i in
                RoundedRectangle(cornerRadius: 8)
                    .fill(userAnswer.indices.contains(i) ? Color.lightGreen : Color.babyLavender)
                    .frame(width: 36, height: 36)
                    .overlay {
                        if userAnswer.indices.contains(i) {
                            Text(userAnswer[i].letter)
                                .font(.system(size: 32))
                                .foregroundColor(Color.darkGreen)
                        }
                    }
                    .onTapGesture {
                        if userAnswer.indices.contains(i) {
                            userAnswer[i].isClicked = false
                            userAnswer.remove(at: i)
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
                                .font(.custom("Arial", size: 32))
                            .foregroundColor(.letterLavender)
                    }
                    .onTapGesture {
                        if userAnswer.count < questionViewModel.questions[questionViewModel.levelNumber - 1].answer.count {
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
        userAnswer.append(item)
        
        // check if user fill all letters
        if userAnswer.count == questionViewModel.questions[questionViewModel.levelNumber - 1].answer.count {
            
            var fullUserAnswer = ""
            userAnswer.forEach({ fullUserAnswer += $0.letter })
            
            // check if user answer and quastion answer is sama
            if fullUserAnswer.lowercased() == questionViewModel.questions[questionViewModel.levelNumber - 1].answer.lowercased() {
                handleCorrectAnswer()
            } else {
                handleWrongAnswer()
            }
        }
    }
    
    func handleCorrectAnswer() {
        print("Win!!")
        // show Excellent view
        
        // remove userAnswer
        userAnswer.removeAll()
        
        questionViewModel.userWonTheLevel()

    }
    
    func handleWrongAnswer() {
        withAnimation(.default) {
            self.attempts += 1
            userAnswer.removeAll()
            questionViewModel.randomLetter.forEach({ $0.isClicked = false })
        }
    }
}
