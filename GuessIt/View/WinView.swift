//
//  WinView.swift
//  GuessIt
//
//  Created by Khawlah on 05/01/2023.
//

import SwiftUI

struct WinView: View {
    var body: some View {
        ZStack{
            
            Image("bg_sunburst")
                .background (Color.babyLavender)
                .ignoresSafeArea()
            
            VStack{
                
//                Circle()
//                    .fill(Color.customOrange)
//                    .frame(width: 100, height: 100)
                
                
                Rectangle()
                    .fill(Color.babyYellow)
                    .frame(width: 348, height: 305)
                    .mask(RoundedRectangle (cornerRadius: 16, style: .continuous))
                
                
                        .overlay(alignment: .top) {
                            Circle()
                        .frame(width: 90, height: 96)
                        .offset(y: -48)
                        .overlay {
                    Image(systemName: "checkmark")
                    .foregroundColor (.white)
                    .frame(width: 67, height: 77)
                    .offset(y: -45)
                        }
                            }
                
//                Image(systemName: "checkmark")
//                    .foregroundColor (.white)
                
                        .overlay(Text("Excellent !"), alignment: .center)
                        .font(.title.weight (.bold))
                        .foregroundColor (Color.customOrange)
                
                
                
                
                        .overlay(alignment: .center){
                            Rectangle()
                                .fill(Color.customOrange)
                                .frame(width: 210, height: 130)
                                .mask(   RoundedRectangle(cornerRadius: 16)
                        .stroke((Color.white), lineWidth: 3)
                                )   }
                
                
                
                
//                                .frame(width: 210, height: 132)
//                                .mask(RoundedRectangle (cornerRadius: 16, style: .continuous, (Color.customOrange))
                               // .border(Color.customOrange)
                   
                
                
                Button (action: {}, label: {
                Text ("Next Level")
                .font(.title2.weight (.semibold))
                .foregroundColor (.white)
                .frame (width: 265, height:44) .background (Color.customOrange)
                .mask(RoundedRectangle (cornerRadius: 16, style: .continuous))

                })

                Button (action: {}, label: {
                Text ("Quit")
                .font(.title2.weight (.semibold))
                .foregroundColor (.white)
                .frame (width: 265, height:44) .background (Color.customOrange)
                .mask(RoundedRectangle (cornerRadius: 16, style: .continuous))

                })
                        
            }
           
//            Image(systemName: "checkmark")
//              .resizable()
//              .frame(width: 80, height: 86)
//              .foregroundColor(.white)
//              .padding(20)
//              .background(Color.customOrange)
//              .clipShape(Circle())
//              .offset(y: -200)
//
            
        }
        }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
    }
}
