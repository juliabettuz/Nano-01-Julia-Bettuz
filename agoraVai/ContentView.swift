//
//  ContentView.swift
//  agoraVai
//
//  Created by Julia Bettuz on 27/07/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var cardViewModel: CardViewModel = CardViewModel()
    var body: some View {
        VStack {
            
            Button {
                
            } label: {
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text("Existential")
                    .font(.title.bold())
            )
            .foregroundColor(.black)
            .padding()
            ZStack {
                Image("loadingCard")
                StackCardView(cardViewModel: cardViewModel)
                
            }
            .padding(.top, 30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
