//
//  Deck.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation

class Deck {
    private var allCards: [Card] = []
    var cards: [Card] = []
    var isCSADeck = false

    
    init(isCSADeck: Bool = false) {
        for suit in Card.validSuits() {
            for rank in Card.validRanks() {
                allCards.append(Card(rank: rank, suit: suit))
            }
        }
        //!! Removing this until CSA implementation
        if isCSADeck {
            allCards.append(Card(rank: .joker, suit: .any))
        }
        resetCards()
    }
    
    func getCard(rank: Int = 15, suit: Int = 4) -> Card? {
        var internalRank = rank
        var internalSuit = suit
        
        if internalSuit == 4 {
            let suits = Card.validSuits()
            internalSuit = suits.randomElement()!.rawValue
        }
        
        if internalRank < 15 {
            if internalRank == 1 {
                internalRank = 14
            }
            if let card = cards.first(where: {$0.rank == CardRank.rank(value: internalRank) && $0.suit.rawValue == internalSuit}) {
                cards.removeAll(where: {$0.rank == card.rank && $0.suit == card.suit})
                print("Drawing the \(String(describing: card.rank)) of \(String(describing: card.suit))")
                return card
            } else {
                if let card = cards.first(where: {$0.rank == CardRank.rank(value: internalRank) && $0.suit.rawValue != internalSuit}) {
                    cards.removeAll(where: {$0.rank == card.rank && $0.suit == card.suit})
                    print("Drawing replacement suited card: \(String(describing: card.rank)) of \(String(describing: card.suit))")
                    return card
                } else {
                    print("Cannot find any cards of that rank")
                }
                
            }
        } else {
            if let card = cards.randomElement() {
                cards.removeAll(where: {$0.rank == card.rank && $0.suit == card.suit})
                return card
            } else {
                print("No cards remaining")
            }
        }
        return nil
    }
    
    func resetCards() {
        cards = allCards
    }
}
