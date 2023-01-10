//
//  QuestionModel.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import Foundation

enum QuestionType: String {
    case country = "Country"
    case city = "City"
    case food = "Food"
    case animal = "Animal"
    case name = "Name"
    
}

struct Question {
    let questionType: QuestionType
    let emojis: String
    let answer: String
}

extension Question {
    static var englishQuestions = [
          Question(questionType: .city, emojis: "🌊🦉", answer: "Seoul")
        , Question(questionType: .food, emojis: "🧔🏻‍♂️ + go", answer: "Mango")
        , Question(questionType: .country, emojis: "🍫🌧", answer: "Bahrain")
        , Question(questionType: .food, emojis: "🧊🧴", answer: "Ice Cream")
        , Question(questionType: .animal, emojis: "🌙🔑", answer: "Monkey")
        , Question(questionType: .country, emojis: "O + 🧔🏻‍♂️", answer: "Oman")
        , Question(questionType: .food, emojis: "🚗✉️", answer: "Carmel")
        , Question(questionType: .city, emojis: "🐁🐮", answer: "Moscow")
        , Question(questionType: .country, emojis: "🌶️", answer: "Chile")
        , Question(questionType: .food, emojis: "🪑 + Y", answer: "Cherry")
        , Question(questionType: .country, emojis: "🐳 + S", answer: "Wales")
        , Question(questionType: .food, emojis: "🔥🍫", answer: "Hot Chocolate")
        , Question(questionType: .country, emojis: "🦃", answer: "Turkey")
        , Question(questionType: .food, emojis: "🧀🍰", answer: "Cheese cake")
    ]
    
    static var arabicQuestions = [
        Question(questionType: .name, emojis: " 💰 + ج", answer: "جمال"),
        Question(questionType: .city, emojis: "ي + 🐻", answer: "دبي"),
        Question(questionType: .food, emojis: " ب + 👁️", answer: "عنب"),
        Question(questionType: .country, emojis: " 💰 + صو", answer: "صومال"),
        Question(questionType: .name, emojis: "🔥💦", answer: "منار"),
        Question(questionType: .city, emojis: "ة + 🦔", answer: "القنفذة"),
        Question(questionType: .food, emojis: " يخ + 🦆", answer: "بطيخ"),
        Question(questionType: .country, emojis: "ون + 📷", answer: "كاميرون"),
        Question(questionType: .name, emojis: "💦 + اس", answer: "اسماء"),
        Question(questionType: .city, emojis: "👵🏻", answer: "جدة"),
        Question(questionType: .food, emojis: "🇸🇩🫘", answer: "فول سوداني"),
        Question(questionType: .country, emojis: "ر + 🐱", answer: "قطر"),
        Question(questionType: .food, emojis: " 🍚 + ك", answer: "كرز"),
        Question(questionType: .city, emojis: "💀💀💀 + ام", answer: "ام الجماجم"),
        Question(questionType: .city, emojis: "👸🏼", answer: "شقراء"),
        Question(questionType: .city, emojis: "🌞🌞", answer: "الشماسية"),
        Question(questionType: .city, emojis: "🌱🌱🌱🌱", answer: "حقل"),

        
        
        
        
        
        
        
        
        
        
        
        
        
    ]
}
