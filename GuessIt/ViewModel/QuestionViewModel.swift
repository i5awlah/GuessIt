//
//  QuestionViewModel.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

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
    
    @Published var showWinView = false
    @Published var attempts: Int = 0
    
    @Published var selectedLevel: Int
    @Published var goLevel = false

    
    let coinsWhenWin = 10
    let coinsWhenHint = 5
    
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
        
        self.selectedLevel = 0
        
        if self.isLastLevel {
            self.selectedLevel = UserDefaults.standard.integer(forKey: "levelNumber") - 1
        } else {
            self.selectedLevel = UserDefaults.standard.integer(forKey: "levelNumber")
        }
        
        
        checkIfLastLevel()
        print("coin: \(coin)")
        print("levelNumber: \(levelNumber)")
        getRandomLetter()
        
//        if isWinLevel {
//            questions[selectedLevel].answer.forEach({ userAnswer.append( Letter(letter: String($0)) ) })
//        }
    }
    
    func getRandomLetter() {
        randomLetter.removeAll()
        // Add each letter of answer to array
        questions[selectedLevel].answer.forEach({ self.randomLetter.append(Letter(letter: String($0))) })
        
        // Calc remind letters
        let remindLetterCount = 20 - questions[selectedLevel].answer.count
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
        if !questions.indices.contains(selectedLevel+1) {
            isLastLevel = true
            print("Finish All level!")
        } else {
            isLastLevel = false
        }
    }
    
    func gotoNextLevel() {
        print("selectedLevel: \(selectedLevel)")
        print("levelNumber: \(levelNumber)")
        // go to next level
        if selectedLevel == levelNumber {
            levelNumber += 1
        }
        if !isLastLevel {
            selectedLevel += 1
        }
        
        isWinLevel = false
        print("+selectedLevel: \(selectedLevel)")
        print("levelNumber: \(levelNumber)")
        getRandomLetter()
        
        // remove previos userAnswer
        userAnswer.removeAll()
        isWinLevel = false
        
    }
    
    func useHint() {
        // sub coin
        coin -= coinsWhenHint
        let letterHint = "\(questions[selectedLevel].answer[userAnswer.count])"
        userAnswer.append(Letter(letter: letterHint))
        
        // check if user fill all letters
        handleFillAllLetters()
    }
    
    func handleAddingLetterToAnswer(item: Letter) {
        // haptic
        HapticManager.instance.impact(style: .medium)
        
        item.isClicked = true
        userAnswer.append(item)
        
        // check if user fill all letters
        handleFillAllLetters()
    }
    
    func handleFillAllLetters() {
        if userAnswer.count == questions[selectedLevel].answer.count {
            var fullUserAnswer = ""
            userAnswer.forEach({ fullUserAnswer += $0.letter })
            
            // check if user answer and quastion answer is sama
            if fullUserAnswer.lowercased() == questions[selectedLevel].answer.lowercased() {
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
        isWinLevel = true
        // show Excellent view
        withAnimation(.easeIn) {
            showWinView.toggle()
        }
        if selectedLevel == levelNumber {
            print("increaseCoins")
            increaseCoins()
        } else {
            print("Not -")
        }
        
        checkIfLastLevel()
    }
    
    func handleWrongAnswer() {
        SoundManager.shared.playSound(soundType: .wrongSound)
        withAnimation(.default) {
            self.attempts += 1
            userAnswer.removeAll()
            randomLetter.forEach({ $0.isClicked = false })
        }
    }
    
    func getEmojiLabel() -> String {
        let letters = "ابتثحخدذرزسشصضطظعغفقكلمنهويءئؤةى"
        let count = letters.filter({ questions[selectedLevel].emojis.contains(String($0))}).count
        if count == 0 && appLanguage == "ar" {
            return String(questions[selectedLevel].emojis.reversed())
        } else {
            return questions[selectedLevel].emojis
        }
    }
    
    func shareQuestion() {
        let AV = UIActivityViewController(activityItems: [
            "Can you guess the name of".localized + " \(questions[selectedLevel].questionType.rawValue.localized) " + "from this emoji".localized + " (" + "\(getEmojiLabel())" + ")" + "?".localized
        ], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
           let windowScene = scenes.first as? UIWindowScene
            
           windowScene?.keyWindow?.rootViewController?.present(AV, animated: true, completion: nil)
    }
}
