//
//  CardTableViewModel.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation
import Combine
import SwiftUI

class CardTableViewModel: ObservableObject {
    //var roundInterstitialViewModel = RoundInterstitalViewModel()
    var boardBuilder = BoardBuilder()
    var currentHand: [Card] = []
    let board = PGPBoard()
    private var index = -1
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var dealerHairOne: CardImage = CardImage(imageName: "card_back")
    @Published var dealerHairTwo: CardImage = CardImage(imageName: "card_back")
    
    @Published var dealerMainOne: CardImage = CardImage(imageName: "card_back")
    @Published var dealerMainTwo: CardImage = CardImage(imageName: "card_back")
    @Published var dealerMainThree: CardImage = CardImage(imageName: "card_back")
    @Published var dealerMainFour: CardImage = CardImage(imageName: "card_back")
    @Published var dealerMainFive: CardImage = CardImage(imageName: "card_back")
    
    @Published var playerHandOne: CardImage = CardImage(imageName: "card_back")
    @Published var playerHandTwo: CardImage = CardImage(imageName: "card_back")
    @Published var playerHandThree: CardImage = CardImage(imageName: "card_back")
    @Published var playerHandFour: CardImage = CardImage(imageName: "card_back")
    @Published var playerHandFive: CardImage = CardImage(imageName: "card_back")
    @Published var playerHandSix: CardImage = CardImage(imageName: "card_back")
    @Published var playerHandSeven: CardImage = CardImage(imageName: "card_back")
    
    @Published var playerHands: [[CardImage]] = []
    
    @Published var showingRoundInterstitial = false
    
    @Published var hwyToggle = false
    
    init() {
        setBoard()
    }
    
    func setBoard() {
        boardBuilder.resetDeck()
        currentHand = boardBuilder.randomBoard()
        playerHandOne = CardImage(card: currentHand[0])
        playerHandTwo = CardImage(card: currentHand[1])
        playerHandThree = CardImage(card: currentHand[2])
        playerHandFour = CardImage(card: currentHand[3])
        playerHandFive = CardImage(card: currentHand[4])
        playerHandSix = CardImage(card: currentHand[5])
        playerHandSeven = CardImage(card: currentHand[6])
    }
    
    func hideHand() {
        dealerHairOne = CardImage(imageName: "card_back")
        dealerHairTwo = CardImage(imageName: "card_back")
        
        dealerMainOne = CardImage(imageName: "card_back")
        dealerMainTwo = CardImage(imageName: "card_back")
        dealerMainThree = CardImage(imageName: "card_back")
        dealerMainFour = CardImage(imageName: "card_back")
        dealerMainFive = CardImage(imageName: "card_back")
    }
    
    func next() {
        boardBuilder.resetDeck()
        hideHand()
        if hwyToggle {
            currentHand = boardBuilder.randomCardsWithJoker()
        } else {
            currentHand = boardBuilder.randomBoard()
        }
        
        playerHandOne = CardImage(card: currentHand[0])
        playerHandTwo = CardImage(card: currentHand[1])
        playerHandThree = CardImage(card: currentHand[2])
        playerHandFour = CardImage(card: currentHand[3])
        playerHandFive = CardImage(card: currentHand[4])
        playerHandSix = CardImage(card: currentHand[5])
        playerHandSeven = CardImage(card: currentHand[6])
        
        

        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .ten, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .two, suit: .hearts)]
        
        let playerCards = [Card(rank: .eight, suit: .clubs),
                           Card(rank: .nine, suit: .spades),
                           Card(rank: .nine, suit: .clubs),
                           Card(rank: .five, suit: .diamonds),
                           Card(rank: .queen, suit: .diamonds),
                           Card(rank: .three, suit: .spades),
                           Card(rank: .two, suit: .spades)]
        
        let dealerHand = board.getHandFromCards(cards: cards)
        let playerHand = board.getHandFromCards(cards: playerCards)
        
        let compare = board.getHandComparison(dealerHand: dealerHand, playerHand: playerHand)
        
        print(compare)
        
//        let answer = board.getHandFromCards(cards: cards)
//        var cardsText = "Cards: "
//        for card in cards {
//            cardsText.append("\(card.description()) ")
//        }
//
//        print(cardsText)
//        
//        print("Straight: ")
//        let hasJoker = cards.contains(where: { $0.rank == .joker })
//        if let hand = board.getStraightHand(cards: cards, hasJoker: hasJoker) {
//            print(hand.description())
//        } else {
//            print("No straights")
//        }
//        
//        print("Flushes: ")
//        if let hand = board.getFlushHand(cards: cards, pairs: []) {
//            print(hand.description())
//        } else {
//            print("No flushes")
//        }
//        
//        print("Answer: ")
//        print(answer.description())
//        
//        print("Bonus: ")
//        print(board.getBonusForCards(cards: cards))
    }
    
    func answer() {
        let answer = board.getHandFromCards(cards: currentHand)
        dealerHairOne = CardImage(card: answer.low[0])
        dealerHairTwo = CardImage(card: answer.low[1])
        dealerMainOne = CardImage(card: answer.high[0])
        dealerMainTwo = CardImage(card: answer.high[1])
        dealerMainThree = CardImage(card: answer.high[2])
        dealerMainFour = CardImage(card: answer.high[3])
        dealerMainFive = CardImage(card: answer.high[4])
    }
}
