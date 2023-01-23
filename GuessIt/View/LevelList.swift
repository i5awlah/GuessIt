//
//  LevelList.swift
//  GuessIt
//
//  Created by Khawlah on 23/01/2023.
//

import SwiftUI

struct LevelList: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 160), spacing: 16)
                ],
                spacing: 16) {
                    ForEach(1...questionViewModel.questions.count, id: \.self) { i in

                        Button {
                            questionViewModel.selectedLevel = i-1
                            questionViewModel.getRandomLetter()
                            questionViewModel.goLevel.toggle()
                        } label: {
                            LevelCell(i: i)
                        }
                        .disabled(i-1 > questionViewModel.levelNumber ? true: false)
                        .navigationDestination(isPresented: $questionViewModel.goLevel) {
                            LevelView()
                                .navigationBarBackButtonHidden(true)
                        }
                    }
                }
                .padding(.horizontal, 16)
        }
    }
}

struct LevelList_Previews: PreviewProvider {
    static var previews: some View {
        LevelList()
            .environmentObject(QuestionViewModel())
    }
}
