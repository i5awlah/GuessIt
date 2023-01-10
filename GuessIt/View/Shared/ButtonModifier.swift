//
//  OrangeButton.swift
//  GuessIt
//
//  Created by Khawlah on 09/01/2023.
//

import SwiftUI

struct OrangeButton: ButtonStyle {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .font(.textInButtonFont(for: questionViewModel.appLanguage))
            .foregroundColor (.white)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(Color.customOrange)
            .cornerRadius(16)
            .frame(height: 44)
            .padding(.horizontal, 64)
    }
}

struct OrangeButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(OrangeButton())
        .environmentObject(QuestionViewModel())
    }
}
