//
//  QuestionViewModel.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import Foundation

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question]
    @Published var randomLetter: [Letter] = []
    @Published var coin = 0
    @Published var levelNumber = 1
    
    init() {
        // fetch questions
        questions = Question.questions
        
        // fetch coin and level from UserDefault
    }
    
    func getRandomLetter() {
        randomLetter.removeAll()
        // Add each letter of answer to array
        questions[levelNumber - 1].answer.forEach({ self.randomLetter.append(Letter(letter: String($0))) })
        
        // Calc remind letters
        let remindLetterCount = 20 - questions[levelNumber - 1].answer.count
        let remindRandomLetters = randomLetters(length: remindLetterCount)
        
        // Add Remind Random Letters to array
        remindRandomLetters.forEach({ self.randomLetter.append(Letter(letter: String($0))) })
        
        // shuffle array
        self.randomLetter.shuffle()
    }
    
    func randomLetters(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func userWonTheLevel() {
        // increase coins
        coin += 10
        
        // go to next level
        levelNumber += 1
        
        getRandomLetter()
    }
}
