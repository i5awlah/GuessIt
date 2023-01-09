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
    @Published var coin: Int {
        didSet {
            UserDefaults.standard.set(coin, forKey: "coin")
        }
    }
    
    @Published var coin2: Int {
        didSet {
            UserDefaults.standard.set(coin2, forKey: "coin2")
        }
    }
    
    @Published var levelNumber: Int {
        didSet {
            UserDefaults.standard.set(levelNumber, forKey: "levelNumber")
        }
    }
    
    @Published var appLanguage = "en"
    
    init() {
        questions = Question.englishQuestions
        // fetch questions based on language
        if let language = Locale.current.language.languageCode?.identifier {
            if language == "ar" {
                appLanguage = "ar"
                questions = Question.arabicQuestions
            } else if language == "en" {
                appLanguage = "en"
                questions = Question.englishQuestions
            }
        }
        
        // fetch coin and level from UserDefault
        self.coin = UserDefaults.standard.integer(forKey: "coin")
        self.coin2 = UserDefaults.standard.integer(forKey: "coin2")
        self.levelNumber = UserDefaults.standard.integer(forKey: "levelNumber")
        print("coin: \(coin)")
        print("coin2: \(coin2)")
        print("levelNumber: \(levelNumber)")
    }
    
    func getRandomLetter() {
        randomLetter.removeAll()
        // Add each letter of answer to array
        questions[levelNumber].answer.forEach({ self.randomLetter.append(Letter(letter: String($0))) })
        
        // Calc remind letters
        let remindLetterCount = 20 - questions[levelNumber].answer.count
        let remindRandomLetters = randomLetters(length: remindLetterCount)
        
        // Add Remind Random Letters to array
        remindRandomLetters.forEach({ self.randomLetter.append(Letter(letter: String($0))) })
        
        // shuffle array
        self.randomLetter.shuffle()
    }
    
    func randomLetters(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz".localized
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func userWonTheLevel() {
        // increase coins
        coin += 10
        print("+coin: \(coin)")
        
        coin2 += 1
        print("+coin2: \(coin2)")
        
        print("levelNumber: \(levelNumber)")
        
        if questions.indices.contains(levelNumber+1) {
            // go to next level
            levelNumber += 1
            print("+levelNumber: \(levelNumber)")
            getRandomLetter()
        } else {
            print("Finish All level!")
        }
        
    }
}
