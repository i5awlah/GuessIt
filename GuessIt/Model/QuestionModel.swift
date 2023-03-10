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
        Question(questionType: .city, emojis: "๐๐ฆ", answer: "Seoul")
        , Question(questionType: .food, emojis: "๐ง๐ปโโ๏ธ + go", answer: "Mango")
        , Question(questionType: .country, emojis: "๐ซ๐ง", answer: "Bahrain")
        , Question(questionType: .food, emojis: "๐ง๐งด", answer: "Ice Cream")
        , Question(questionType: .animal, emojis: "๐๐", answer: "Monkey")
        , Question(questionType: .country, emojis: "O + ๐ง๐ปโโ๏ธ", answer: "Oman")
        , Question(questionType: .food, emojis: "๐โ๏ธ", answer: "Caramel")
        , Question(questionType: .city, emojis: "๐๐ฎ", answer: "Moscow")
        , Question(questionType: .animal, emojis: "๐ง + no", answer: "Rhino")
        , Question(questionType: .country, emojis: "๐ถ๏ธ", answer: "Chile")
        , Question(questionType: .food, emojis: "๐ช + Y", answer: "Cherry")
        , Question(questionType: .animal, emojis: "โ๏ธ + G + ๐ฅ", answer: "Penguin")
        , Question(questionType: .country, emojis: "๐ณ + S", answer: "Wales")
        , Question(questionType: .animal, emojis: "๐ท + L", answer: "Camel")
        , Question(questionType: .food, emojis: "๐ฅ๐ซ", answer: "Hot Chocolate")
        , Question(questionType: .country, emojis: "๐ฆ", answer: "Turkey")
        , Question(questionType: .animal, emojis: "๐ฑ๏ธ๐๐ป", answer: "Bear")
        , Question(questionType: .food, emojis: "๐ง๐ฐ", answer: "Cheese Cake")
        , Question(questionType: .country, emojis: "Ja + ๐ณ", answer: "Japan")
        , Question(questionType: .food, emojis: "๐ฅ๐ค", answer: "Milkshake")
        , Question(questionType: .animal, emojis: "โ๏ธ", answer: "Cat")
        , Question(questionType: .country, emojis: "โ๏ธ๐ฐ๏ธ", answer: "China")
        , Question(questionType: .animal, emojis: "๐ฑ๏ธ๐๐ป", answer: "Bear")
        , Question(questionType: .country, emojis: "๐1๏ธโฃ", answer: "Taiwan")
        , Question(questionType: .food, emojis: "๐ง๐ปโ๐ณ๐ ", answer: "Cookie")
        , Question(questionType: .animal, emojis: "โ๏ธ๐", answer: "Donkey")
        , Question(questionType: .food, emojis: "๐ฅ๐ฝ", answer: "Popcorn")
        , Question(questionType: .animal, emojis: "๐๐ง๐ป", answer: "Tiger")
        , Question(questionType: .food, emojis: " ๐พ๏ธ๐๐ปโโ๏ธG", answer: "Orange")
        , Question(questionType: .animal, emojis: "๐ณ + da", answer: "Panda")
        , Question(questionType: .food, emojis: "๐ฆ๐ป + Y", answer: "Blueberry")
        , Question(questionType: .country, emojis: "๐ฆ?๐ฐ", answer: "Germany")
        , Question(questionType: .city, emojis: "๐๐จโ๐ฆ", answer: "Baghdad")
        , Question(questionType: .food, emojis: "๐ฅต๐ถ", answer: "Hotdog")
        , Question(questionType: .country, emojis: "๐๐๐ป", answer: "Belgium")
    ]
    
    static var arabicQuestions = [
        Question(questionType: .city, emojis: "๐ป + ู", answer: "ุฏุจู"),
        Question(questionType: .name, emojis: "ุฌ + ๐ฐ", answer: "ุฌูุงู"),
        Question(questionType: .food, emojis: "๐๏ธ + ุจ", answer: "ุนูุจ"),
        Question(questionType: .country, emojis: "ุตู + ๐ฐ", answer: "ุตููุงู"),
        Question(questionType: .name, emojis: "๐ฅ๐ฆ", answer: "ููุงุฑ"),
        Question(questionType: .city, emojis: "๐ฆ + ุฉ", answer: "ุงููููุฐุฉ"),
        Question(questionType: .food, emojis: "๐ฆ + ูุฎ", answer: "ุจุทูุฎ"),
        Question(questionType: .country, emojis: "๐ท + ูู", answer: "ูุงููุฑูู"),
        Question(questionType: .name, emojis: "ุฃุณ + ๐ฆ", answer: "ุฃุณูุงุก"),
        Question(questionType: .city, emojis: "๐ต๐ป", answer: "ุฌุฏุฉ"),
        Question(questionType: .country, emojis: "๐ฑ + ุฑ", answer: "ูุทุฑ"),
        Question(questionType: .food, emojis: "ู + ๐", answer: "ูุฑุฒ"),
        Question(questionType: .city, emojis: "ุฃู +๐๐๐", answer: "ุฃู ุงูุฌูุงุฌู"),
        Question(questionType: .city, emojis: "๐ธ๐ผ", answer: "ุดูุฑุงุก"),
        Question(questionType: .city, emojis: "๐๐", answer: "ุงูุดูุงุณูุฉ"),
        Question(questionType: .city, emojis: "๐ฑ๐ฑ๐ฑ๐ฑ", answer: "ุญูู"),
        Question(questionType: .food, emojis: "๐๐", answer: "ูุฑู ุนูุจ"),
        Question(questionType: .city, emojis: "๐จ๐ป๐ฆ", answer: "ุฃุจู ุธุจู"),
        Question(questionType: .food, emojis: "๐๐ฅ", answer: "ุจูุถ ุนููู"),
        Question(questionType: .city, emojis: "๐๏ธ๐ฉธ", answer: "ุฏูุดู"),
        Question(questionType: .food, emojis: "2๏ธโฃ๐จ๐ป", answer: "ููุชู"),
        Question(questionType: .animal, emojis: "ุฐ + ๐ช", answer: "ุฐุจุงุจ"),
        Question(questionType: .food, emojis: "๐ฐ๐", answer: "ุฌูุจ ุงูุชุงุฌุฑ"),
        Question(questionType: .city, emojis: "๐๐", answer: "ูุฑุณุงู"),
        Question(questionType: .food, emojis: "๐ฟ๐ฟ", answer: "ูุฑุตุงู"),
        Question(questionType: .city, emojis: "๐ซ + ุฉ", answer: "ุจุฑูุฏุฉ"),
        Question(questionType: .food, emojis: "ุฌ +๐ชถ", answer: "ุฌุฑูุด"),
        Question(questionType: .city, emojis: "โจ๐จ๐ป๐จ๐ป๐จ๐ป", answer: "ุฑุฌุงู ุฃููุน"),
        Question(questionType: .food, emojis: "๐ฆ๐ฟ", answer: "ุดุงูุฑูุง"),
        Question(questionType: .country, emojis: "๐ฅ๐ฅ", answer: "ูุจูุงู"),
        Question(questionType: .food, emojis: "ู + ๐ช", answer: "ูุจุงุจ"),
        Question(questionType: .city, emojis: "ุช + ๐", answer: "ุชุจูู"),
        Question(questionType: .food, emojis: "๐ฉ๐ปโ๐ฆฑ", answer: "ููุงูู"),
        Question(questionType: .country, emojis: "ุบ + ๐๐ปโโ๏ธ", answer: "ุบุงูุง"),
        Question(questionType: .food, emojis: "4๏ธโฃ๐ก", answer: "ุจูุชูููุฑ")
    ]
}
