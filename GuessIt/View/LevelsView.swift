//
//  LevelsView.swift
//  GuessIt
//
//  Created by Khawlah on 21/01/2023.
//

import SwiftUI

struct LevelsView: View {
    
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.linearGradient
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                CustomNavBar(
                    title: "LEVELS",
                    showLevelNumber: false,
                    backLabel: "Start Page",
                    showAccessibilityLevelValue: false
                )
                LevelList()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LevelsView()
                .environmentObject(QuestionViewModel())
        }
    }
}
