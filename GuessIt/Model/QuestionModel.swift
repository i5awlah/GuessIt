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
    let fullAnswer: String
    let answer: String
    
    init(questionType: QuestionType, emojis: String, answer: String) {
        self.questionType = questionType
        self.emojis = emojis
        self.fullAnswer = answer
        self.answer = answer.filter({ $0 != " " })
    }
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
        , Question(questionType: .animal, emojis: "🌧 + no", answer: "Rhino")
        , Question(questionType: .country, emojis: "🌶️", answer: "Chile")
        , Question(questionType: .food, emojis: "🪑 + Y", answer: "Cherry")
        , Question(questionType: .animal, emojis: "✒️ + G + 🥇", answer: "Penguin")
        , Question(questionType: .country, emojis: "🐳 + S", answer: "Wales")
        , Question(questionType: .animal, emojis: "📷 + L", answer: "Camel ")
        , Question(questionType: .food, emojis: "🔥🍫", answer: "Hot Chocolate")
        , Question(questionType: .country, emojis: "🦃", answer: "Turkey")
        , Question(questionType: .animal, emojis: "🅱️👂🏻", answer: "Bear")
        , Question(questionType: .food, emojis: "🧀🍰", answer: "Cheese Cake")
        , Question(questionType: .country, emojis: "Ja + 🍳", answer: "Japan")
        , Question(questionType: .animal, emojis: "🍳 + da", answer: "Panda")
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
        Question(questionType: .food, emojis: "🍇📄", answer: "ورق عنب"),
        Question(questionType: .country, emojis: "🐱 + ر", answer: "قطر"),
        Question(questionType: .food, emojis: "ك + 🍚", answer: "كرز"),
        Question(questionType: .city, emojis: "أم +💀💀💀", answer: "أم الجماجم"),
        Question(questionType: .city, emojis: "👸🏼", answer: "شقراء"),
        Question(questionType: .city, emojis: "🌞🌞", answer: "الشماسية"),
        Question(questionType: .food, emojis: "👀🥚", answer: "بيض عيون"),
        Question(questionType: .city, emojis: "🌱🌱🌱🌱", answer: "حقل"),
        Question(questionType: .food, emojis: "💰🚙", answer: "جيب التاجر"),
        Question(questionType: .city, emojis: "👨🏻🦌", answer: "أبو ظبي"),
        Question(questionType: .city, emojis: "🏚️🩸", answer: "دمشق"),
        Question(questionType: .food, emojis: "2️⃣👨🏻", answer: "منتو"),
        Question(questionType: .city, emojis: "✨👨🏻👨🏻👨🏻", answer: "رجال ألمع"),
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
