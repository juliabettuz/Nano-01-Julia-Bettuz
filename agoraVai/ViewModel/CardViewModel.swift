//
//  CardViewModel.swift
//  agoraVai
//
//  Created by Julia Bettuz on 28/07/23.
//

import SwiftUI

class CardViewModel: ObservableObject {
    @Published var current: Cards = Cards.returnCard(current: .card0)
    
    func leftSwipe() {
        if let nextCard = current.leftChoice?.nextCard {
            current = Cards.returnCard(current: nextCard)
        } else if let nextCard = current.nextCard {
            current = Cards.returnCard(current: nextCard)
        }
    }
    
    func rightSwipe() {
        if let nextCard = current.rightChoice?.nextCard {
            current = Cards.returnCard(current: nextCard)
        } else if let nextCard = current.nextCard {
            current = Cards.returnCard(current: nextCard)
        }
    }
}
