//
//  Model.swift
//  Nano01
//
//  Created by Julia Bettuz on 27/07/23.
//

import Foundation
import SpriteKit

enum Card {
    case card1
    case card2
    case card3
    case card4
    case split1
    case split2
    case card5
    case split3
    case split4
    case card6
    case impossible
    case card7
    case end
}

struct Choice: Equatable {
    let textChoice: String
    let nextCard: Card
}

struct Cards: Equatable {
    static func == (lhs: Cards, rhs: Cards) -> Bool {
            return lhs.text == rhs.text &&
                lhs.rightChoice == rhs.rightChoice &&
                lhs.leftChoice == rhs.leftChoice &&
                lhs.currentCard == rhs.currentCard &&
                lhs.nextCard == rhs.nextCard &&
                lhs.cardColor == rhs.cardColor
        }
    let text: String
    let rightChoice: Choice?
    let leftChoice: Choice?
    let currentCard: Card
    let nextCard: Card?
    let cardColor: UIColor
    
    init(text: String, rightChoice: Choice?, leftChoice: Choice?, currentCard: Card, nextCard: Card?, cardColor: UIColor) {
        self.text = text
        self.rightChoice = rightChoice
        self.leftChoice = leftChoice
        self.currentCard = currentCard
        self.nextCard = nextCard
        self.cardColor = cardColor
    }
    
    
    static func returnCard(current: Card) -> Cards {
        switch current {
        case .card1:
            return Cards(text: "We make around 35,000 decisions per day. Around 120 of those are informed decisions: what to eat, what to dress, what to watch. \n\nAnd, of course, the more impactful ones about our relationships, careers and identities.",
                          rightChoice: nil,
                          leftChoice: nil,
                          currentCard: .card1,
                          nextCard: .card2,
                          cardColor: .systemGray5)
        case .card2:
            return Cards(text: "All of our decisions shape our lives. That's why it's important to reflect: are you being authentic in your decisions? \n\nAccording to Sartre's existentialism, you are always free to choose what to do and acknowledging that is the only way to live authentically.",
                  rightChoice: nil,
                  leftChoice: nil,
                  currentCard: .card2,
                  nextCard: .card3,
                  cardColor: .systemGray5)
        case .card3:
            return Cards(text: "Make a few decisions and reflect on your own life and existentialism.\n\nThere's no right or wrong answer, take the time to think about yourself. \n\nSelect the decisions by swiping this card left or right. Try it on this one.",
                                     rightChoice: Choice(textChoice: "Continue ->", nextCard: .card4),
                                     leftChoice: Choice(textChoice: "<- Continue", nextCard: .card4),
                                     currentCard: .card3,
                                     nextCard: nil,
                                     cardColor: .systemGray5)
        case .card4:
            return Cards(text: "It's your first day at a gym after a long time without any exercise. You get a lot of looks after doing the exercises in the wrong way and you feel embarrassed. \n\nDo you get too self conscious and start avoiding the gym, or you don't mind and just keep going?",
                         rightChoice: Choice(textChoice: "Avoid \nthe gym", nextCard: .split2),
                         leftChoice: Choice(textChoice: "Keep going \nto the gym", nextCard: .split1),
                         currentCard: .card4,
                         nextCard: nil,
                         cardColor: .black)
            
        case .split1:
            return Cards(text: "Don't let others define you. \n\nNot deciding based on other people's opinion means you hone in on your own ability to choose. \n\nAccording to Sartre, only your freedom defines you and nobody can prevent you from acting as you want.",
                         rightChoice: Choice(textChoice: "Continue", nextCard: .card5),
                         leftChoice: Choice(textChoice: "Continue", nextCard: .card5),
                         currentCard: .split1,
                         nextCard: nil,
                         cardColor: .systemGray5)
            
        case .split2:
            return Cards(text: "Shame is shame of self. \n\nDeciding to avoid the gym because of what other people think is actually letting others define you and decide for you, letting go of your innate freedom. \n\nAccording to Sartre, only your freedom defines you and nobody can prevent you from acting as you want.",
                         rightChoice: Choice(textChoice: "Continue", nextCard: .card5),
                         leftChoice: Choice(textChoice: "Continue", nextCard: .card5),
                         currentCard: .split2,
                         nextCard: nil,
                         cardColor: .systemGray5)
            
        case .card5:
            return Cards(text: "You’ve been at the same company for 5 years, but you've been feeling that career is not for you for a while. \n\nYou're stable there and you need the money, but you’re unhappy and wonder if you could do better in another career path. \n\nDo you ignore your desire and stay on the job or leave it?",
                         rightChoice: Choice(textChoice: "Stay \non the job", nextCard: .split3),
                         leftChoice: Choice(textChoice: "Leave \nthe job", nextCard: .split4),
                         currentCard: .card5,
                         nextCard: nil,
                         cardColor: .black)
            
        case .split3:
            return Cards(text: "Not choosing is also choosing. \n\nAccording to Sartre, fear is unavoidable if you want to act and your actions reflect who you are.",
                         rightChoice: Choice(textChoice: "Continue", nextCard: .card6),
                         leftChoice: Choice(textChoice: "Continue", nextCard: .card6),
                         currentCard: .split3,
                         nextCard: nil,
                         cardColor: .systemGray5)
            
        case .split4:
            return Cards(text: "Acting is happy agony.\n\nAccording to Sartre, anguish is a normal feeling and making hard decisions is just a consequence of our freedom.",
                         rightChoice: Choice(textChoice: "Continue", nextCard: .impossible),
                         leftChoice: Choice(textChoice: "Continue", nextCard: .impossible),
                         currentCard: .split4,
                         nextCard: nil,
                         cardColor: .systemGray5)
            
        case .impossible:
            return Cards(text: "The company you work for is in a difficult situation. A significant shareholder meeting is near, and your boss is suggesting that you manipulate the financial data.\n\nIf you present the actual numbers, it is very likely that you and hundreds of other employees will lose your jobs.\n\nHowever, if you slightly manipulate the data, you might be able to save your jobs and gain a few months to help the company truly recover.\n\nWhat do you do?",
                         rightChoice: Choice(textChoice: "Fudge \nthe numbers", nextCard: .card7),
                         leftChoice: Choice(textChoice: "Don't fudge \nthe numbers", nextCard: .card7),
                         currentCard: .card6,
                         nextCard: nil,
                         cardColor: .black)
            
        case .card7:
            return Cards(text: "Take responsibility. \n\nHow does that decision make you feel? \n\nAccording to Sartre, we tend to attribute the blame to other people or the circumstances when we make really hard decisions or take actions we don't feel proud of.",
                         rightChoice: Choice(textChoice: "Continue", nextCard: .end),
                         leftChoice: Choice(textChoice: "Continue", nextCard: .end),
                         currentCard: .card7,
                         nextCard: nil,
                         cardColor: .systemGray5)
            
        case .end:
            return Cards(text: "Thanks for playing! \n\nThis app is made by someone who's interested in existentialism, not a philosopher or psychologist.\n\nIf you're interested in learning about Sartre's existentialism, start by googling about it, watching a few YouTube videos, and, of course, reading his books, such as Existentialism is a Humanism.",
                         rightChoice: Choice(textChoice: "Continue", nextCard: .card1),
                         leftChoice: Choice(textChoice: "Continue", nextCard: .card1),
                         currentCard: .split1,
                         nextCard: nil,
                         cardColor: .systemGray5)
            
        default:
            return Cards(text: "It's your first day at a gym after a long time without any exercise. You get a lot of looks after doing the exercises in the wrong way and you feel embarrassed. \n\nWhat do you do?",
                         rightChoice: Choice(textChoice: "Don't mind and keep going to the gym", nextCard: .split1),
                         leftChoice: Choice(textChoice: "Get too self conscious and start avoiding the gym", nextCard: .split2),
                         currentCard: .card4,
                         nextCard: nil,
                         cardColor: .black)
        }
    }
    
    
}
