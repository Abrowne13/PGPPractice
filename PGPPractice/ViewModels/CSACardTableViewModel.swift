//
//  CardTableViewModel.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation
import Combine
import SwiftUI

class CSACardTableViewModel: ObservableObject {
    //var roundInterstitialViewModel = RoundInterstitalViewModel()
    var boardBuilder = BoardBuilder()
    var dealerCards: [Card] = []
    var dealerHand: PGPHand = PGPHand()
    var playerCards: [Card] = []
    var showAnswerButton = false
    @Published var showNextButton = false
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
    var answerText = ""
    
    func hideHand() {
        dealerHairOne = CardImage(imageName: "card_back")
        dealerHairTwo = CardImage(imageName: "card_back")
        
        dealerMainOne = CardImage(imageName: "card_back")
        dealerMainTwo = CardImage(imageName: "card_back")
        dealerMainThree = CardImage(imageName: "card_back")
        dealerMainFour = CardImage(imageName: "card_back")
        dealerMainFive = CardImage(imageName: "card_back")
    }
    
    func startRound() {
        showAnswerButton = false
        showNextButton = true
        
        boardBuilder.resetCSADeck()
        
        dealerCards = boardBuilder.getCSAHand()
        
        dealerHand = board.getHandFromCards(cards: dealerCards)
        
        dealerHairOne = CardImage(card: dealerHand.low[0])
        dealerHairTwo = CardImage(card: dealerHand.low[1])
        dealerMainOne = CardImage(card: dealerHand.high[0])
        dealerMainTwo = CardImage(card: dealerHand.high[1])
        dealerMainThree = CardImage(card: dealerHand.high[2])
        dealerMainFour = CardImage(card: dealerHand.high[3])
        dealerMainFive = CardImage(card: dealerHand.high[4])
        
        playerHandOne = CardImage(imageName: "card_back")
        playerHandTwo = CardImage(imageName: "card_back")
        playerHandThree = CardImage(imageName: "card_back")
        playerHandFour = CardImage(imageName: "card_back")
        playerHandFive = CardImage(imageName: "card_back")
        playerHandSix = CardImage(imageName: "card_back")
        playerHandSeven = CardImage(imageName: "card_back")
        
    }
    
    func next() {
        
        showAnswerButton = true

        playerCards = boardBuilder.getCSAHand()
        
        if !playerCards.isEmpty {
            playerHandOne = CardImage(card: playerCards[0])
            playerHandTwo = CardImage(card: playerCards[1])
            playerHandThree = CardImage(card: playerCards[2])
            playerHandFour = CardImage(card: playerCards[3])
            playerHandFive = CardImage(card: playerCards[4])
            playerHandSix = CardImage(card: playerCards[5])
            playerHandSeven = CardImage(card: playerCards[6])
        } else {
            print("Deck empty")
            showNextButton = false
        }
        
        
    }
    
    func answer() {
        let bonus = board.getBonusForCards(cards: playerCards)
        let payout = PGPHand.bonusPayout(bonus: bonus)
        let playerHand = board.getHandFromCards(cards: playerCards)
        if !playerHand.low.isEmpty && !playerHand.high.isEmpty {
            let evaluation = board.getHandComparison(dealerHand: dealerHand, playerHand: playerHand)
            let lowHandRank = board.getLowHandRank(cards: playerHand.low)
            let highHandRank = board.getHighHandRank(cards: playerHand.high)
            var lowRankString = ""
            if lowHandRank.pairRank != nil {
                lowRankString = "Pair of \(lowHandRank.pairRank!)s"
            } else {
                lowRankString = "\(lowHandRank.ranks[0]), \(lowHandRank.ranks[1])"
            }
            
            var highRankString = ""
            
            if highHandRank.bonus == .highCard {
                highRankString = "\(highHandRank.cardRank) high"
            } else if highHandRank.bonus == .pair {
                highRankString = "Pair of \(highHandRank.cardRank)s"
            } else {
                highRankString = "\(highHandRank.bonus)"
            }

            if payout > 0 {
                answerText = "low: \(lowRankString)\nhigh: \(highRankString)\nevaluation: \(evaluation)\npayoutRatio: \(payout)"
            } else {
                answerText = "low: \(lowRankString)\nhigh: \(highRankString)\nevaluation: \(evaluation)"
            }
            
        }
    }
}
