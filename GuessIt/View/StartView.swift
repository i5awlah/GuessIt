//
//  StartView.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                LevelView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("start")
            }

        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(QuestionViewModel())
    }
}
