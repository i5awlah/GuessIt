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
    @Published var userAnswer: [Letter] = []
    
    @Published var coin: Int {
        didSet {
            UserDefaults.standard.set(coin, forKey: "coin")
        }
    }
    
    @Published var levelNumber: Int {
        didSet {
            UserDefaults.standard.set(levelNumber, forKey: "levelNumber")
        }
    }
    
    @Published var appLanguage = "en"
    
    @Published var isLastLevel: Bool {
        didSet {
            UserDefaults.standard.set(isLastLevel, forKey: "isLastLevel")
        }
    }
    
    @Published var isWinLevel: Bool {
        didSet {
            UserDefaults.standard.set(isWinLevel, forKey: "isWinLevel")
        }
    }
    
    let coinsWhenWin = 10
    
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
        self.levelNumber = UserDefaults.standard.integer(forKey: "levelNumber")
        
        self.isLastLevel = UserDefaults.standard.bool(forKey: "isLastLevel")
        self.isWinLevel = UserDefaults.standard.bool(forKey: "isWinLevel")
        print("coin: \(coin)")
        print("levelNumber: \(levelNumber)")
        getRandomLetter()
        
        if isWinLevel {
            questions[levelNumber].answer.forEach({ userAnswer.append( Letter(letter: String($0)) ) })
        }
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
    
    func increaseCoins() {
        // increase coins
        coin += coinsWhenWin
        print("+coin: \(coin)")
    }
    
    func checkIfLastLevel() {
        if !questions.indices.contains(levelNumber+1) {
            isLastLevel = true
            print("Finish All level!")
        }
    }
    
    func gotoNextLevel() {
        print("levelNumber: \(levelNumber)")
        
        // go to next level
        levelNumber += 1
        isWinLevel = false
        print("+levelNumber: \(levelNumber)")
        getRandomLetter()
        
        // remove previos userAnswer
        userAnswer.removeAll()
        isWinLevel = false
        
    }
}
