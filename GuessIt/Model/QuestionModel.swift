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
    static var questions = [
        Question(questionType: .city, emojis: "🌞🌞", answer: "الشماسية"),
        Question(questionType: .city, emojis: "🌱🌱🌱🌱", answer: "حقل"),
        Question(questionType: .city, emojis: "👸🏼", answer: "شقراء")
    ]
}
