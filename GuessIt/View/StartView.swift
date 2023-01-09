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

        ZStack{
            (AngularGradient (
                gradient: Gradient(colors: [Color(.gray)]),
                           center: .topLeading,
                           angle: .degrees(180+45)))
             .ignoresSafeArea()
            
            VStack{
                Image("logo")
                    .resizable()
                    .frame (width: 267, height:327)
                    .padding(100)
                
                    
                

                Button (
                    action: {}, label: {
                Text ("Play")
                .font(.title2.weight (.semibold))
                .foregroundColor (.white)
                .frame (width: 265, height:44) .background (Color.customOrange)
                .mask(RoundedRectangle (cornerRadius: 16, style: .continuous))

                }
                        )
//                Image(systemName: "play.fill")
//                    .foregroundColor (.white)
//                    .frame (width: 197, height:44)
            }
            
        }
    }

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(QuestionViewModel())
    }
}
                }
