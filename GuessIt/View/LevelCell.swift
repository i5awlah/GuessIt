//
//  LevelCell.swift
//  GuessIt
//
//  Created by Khawlah on 21/01/2023.
//

import SwiftUI

struct LevelCell: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    let i: Int
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Level \(i)").bold()
            Text("\(questionViewModel.questions[i-1].emojis)")
                .opacity(i-1 > questionViewModel.levelNumber ? 0.2 : 1)
                .font(.title)
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
        }
        .font(.letterFont(for: questionViewModel.appLanguage))
        .foregroundColor(.letterLavender)
        .padding()
        .padding(.bottom, 36)
        .overlay(alignment: .bottom) {
            Circle()
                .fill(
                    i > questionViewModel.levelNumber ?
                    Color.red
                    : Color.green
                )
                .frame(width: 36, height: 36)
                .overlay {
                    if i > questionViewModel.levelNumber {
                        Image(systemName: "lock")
                            .font(.headline)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "checkmark")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .shadow(radius: 2)
                .opacity(i-1 == questionViewModel.levelNumber ? 0 : 1)
                .offset(y: 18)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    i-1 > questionViewModel.levelNumber ?
                    Color("customGrey").opacity(0.4) : Color("customGrey")
                )
        )
        .padding(.bottom, 16)
    }
}

struct LevelCell_Previews: PreviewProvider {
    static var previews: some View {
        LevelCell(i: 4)
            .environmentObject(QuestionViewModel())
    }
}
