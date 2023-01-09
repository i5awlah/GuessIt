//
//  GuessItApp.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

@main
struct GuessItApp: App {
    
    @StateObject var questionViewModel = QuestionViewModel()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(questionViewModel)
        }
    }
}
