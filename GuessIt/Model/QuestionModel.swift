//
//  QuestionModel.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import Foundation

enum QuestionType: String {
    case city = "City"
    case food = "Food"
}

struct Question {
    let questionType: QuestionType
    let emojis: String
    let answer: String
}

extension Question {
    static var englishQuestions = [
        Question(questionType: .city, emojis: "🌊 🦉", answer: "Seoul")
        , Question(questionType: .city, emojis: "🐁🐮", answer: "Moscow")
        , Question(questionType: .city, emojis: "🍫🌧", answer: "Bahrain")
    ]
    
    static var arabicQuestions = [
        Question(questionType: .city, emojis: "🌞🌞", answer: "الشماسية"),
        Question(questionType: .city, emojis: "🌱🌱🌱🌱", answer: "حقل"),
        Question(questionType: .city, emojis: "👸🏼", answer: "شقراء")
    ]
}
