//
//  BoardBuilder.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation

class BoardBuilder {
    private var deck = Deck()
    private var csaDeck = Deck(isCSADeck: true)
    private var currentBoard: [Card] = []
    
    
    func randomBoard() -> [Card] {
        var hand: [Card] = []
        
        for _ in 0...6 {
            if let card = deck.getCard() {
                hand.append(card)
            }
        }
        
        return hand
    }
    
    func randomCardsWithJoker() -> [Card] {
        var cards = randomBoard()
        let index = Int.random(in: 0...6)
        
        //If this is false, the joker is already in the cards
        let joker = Card(rank: .joker, suit: .any)
        cards.replaceSubrange(index...index, with: [joker])
        
        
        return cards
    }
    
    func getCSAHand() -> [Card] {
        var hand: [Card] = []
        
        for _ in 0...6 {
            if let card = csaDeck.getCard() {
                hand.append(card)
            } else {
                print("No more cards")
                return []
            }
        }
        
        return hand
    }
    
    func resetDeck() {
        deck.resetCards()
    }
    
    func resetCSADeck() {
        csaDeck.resetCards()
        
    }
}



