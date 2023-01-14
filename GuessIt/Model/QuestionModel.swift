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
        , Question(questionType: .food, emojis: "🧊🧴", answer: "IceCream")
        , Question(questionType: .animal, emojis: "🌙🔑", answer: "Monkey")
        , Question(questionType: .country, emojis: "O + 🧔🏻‍♂️", answer: "Oman")
        , Question(questionType: .food, emojis: "🚗✉️", answer: "Carmel")
        , Question(questionType: .city, emojis: "🐁🐮", answer: "Moscow")
        , Question(questionType: .country, emojis: "🌶️", answer: "Chile")
        , Question(questionType: .food, emojis: "🪑 + Y", answer: "Cherry")
        , Question(questionType: .country, emojis: "🐳 + S", answer: "Wales")
//        , Question(questionType: .food, emojis: "🔥🍫", answer: "HotChocolate")
        , Question(questionType: .country, emojis: "🦃", answer: "Turkey")
//        , Question(questionType: .food, emojis: "🧀🍰", answer: "CheeseCake")
          , Question(questionType: .country, emojis: "Ja + 🍳", answer: "Japan")
    ]
    
    static var arabicQuestions = [
        Question(questionType: .city, emojis: "🐻 + ي", answer: "دبي"),
        Question(questionType: .name, emojis: "ج + 💰", answer: "جمال"),
        Question(questionType: .food, emojis: "👁️ + ب", answer: "عنب"),
        Question(questionType: .country, emojis: "صو + 💰", answer: "صومال"),
        Question(questionType: .name, emojis: "🔥💦", answer: "منار"),
        Question(questionType: .city, emojis: "🦔 + ة", answer: "القنفذة"),
        Question(questionType: .food, emojis: "🦆 + يخ", answer: "بطيخ"),
        Question(questionType: .country, emojis: "📷 + ون", answer: "كاميرون"),
        Question(questionType: .name, emojis: "أس + 💦", answer: "أسماء"),
        Question(questionType: .city, emojis: "👵🏻", answer: "جدة"),
        Question(questionType: .country, emojis: "🐱 + ر", answer: "قطر"),
        Question(questionType: .food, emojis: "ك + 🍚", answer: "كرز"),
        //Question(questionType: .city, emojis: "أم +💀💀💀", answer: "أمالجماجم"),
        Question(questionType: .city, emojis: "👸🏼", answer: "شقراء"),
        Question(questionType: .city, emojis: "🌞🌞", answer: "الشماسية"),
        Question(questionType: .city, emojis: "🌱🌱🌱🌱", answer: "حقل"),
        Question(questionType: .city, emojis: "🏚️🩸", answer: "دمشق"),
        Question(questionType: .food, emojis: "2️⃣👨🏻", answer: "منتو"),
        Question(questionType: .city, emojis: "ت + 👛", answer: "تبوك"),
        Question(questionType: .animal, emojis: "ذ + 🚪", answer: "ذباب"),
        Question(questionType: .city, emojis: "🐎🐎", answer: "فرسان"),
        Question(questionType: .country, emojis: "غ + 🙋🏻‍♀️", answer: "غانا"),
        Question(questionType: .food, emojis: "💿💿", answer: "قرصان"),
        Question(questionType: .city, emojis: "📫 + ة", answer: "بريدة"),
        Question(questionType: .food, emojis: "ج +🪶", answer: "جريش"),
        Question(questionType: .food, emojis: "4️⃣🏡", answer: "بيتيفور")
        
        
    ]
}
