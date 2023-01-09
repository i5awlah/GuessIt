//
//  LetterModel.swift
//  GuessIt
//
//  Created by Khawlah on 08/01/2023.
//

import Foundation

class Letter {
    let id = UUID()
    let letter: String
    var isClicked = false
    
    init(letter: String) {
        self.letter = letter.uppercased()
    }
}
