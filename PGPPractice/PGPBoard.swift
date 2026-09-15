//
//  PGPBoard.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 3/31/26.
//

import Foundation

enum HandStatus: Comparable {
    case win
    case push
    case lose
}

enum Bonus: String, RawRepresentable, CaseIterable, Equatable {
    case none = "None"
    case highCard = "High Card"
    case pair = "Pair"
    case twoPair = "TwoPair"
    case trips = "Trips"
    case straight = "Straight"
    case flush = "Flush"
    case fullHouse = "Full House"
    case quads = "Quads"
    case straightFlush = "Straight Flush"
    case royalFlush = "Royal Flush"
    case fiveOfAKind = "Five of a Kind"
    case fiveAces = "Five Aces"
    case sevenCardStraightFlush = "Seven Card Straight Flush"
}

struct PGPHand {
    var low: [Card] = []
    var high: [Card] = []
    
    func description() -> String {
        var text = "Low Hand: ["
        
        text.append("\(low[0].description()), \(low[1].description())]\n")
        text.append("High Hand: [")
        
        text.append("\(high[0].description()), \(high[1].description()), ")
        text.append("\(high[2].description()), \(high[3].description()), ")
        text.append("\(high[4].description())]\n")
        
        return text
    }
    
    static let straightHands: [Set<CardRank>] =
    [[.ten, .jack, .king, .queen, .ace],
     [.nine, .ten, .jack, .queen, .king],
     [.eight, .nine, .ten, .jack, .queen],
     [.seven, .eight, .nine, .ten, .jack],
     [.six, .seven, .eight, .nine, .ten],
     [.five, .six, .seven, .eight, .nine],
     [.four, .five, .six, .seven, .eight],
     [.three, .four, .five, .six, .seven],
     [.two, .three, .four, .five, .six],
     [.ace, .two, .three, .four, .five]]
    
    static let sevenCardStraightHands: [Set<CardRank>] =
    [[.eight, .nine, .ten, .jack, .queen, .king, .ace],
     [.seven, .eight, .nine, .ten, .jack, .queen, .king],
     [.six, .seven, .eight, .nine, .ten, .jack, .queen],
     [.five, .six, .seven, .eight, .nine, .ten, .jack],
     [.four, .five, .six, .seven, .eight, .nine, .ten],
     [.three, .four, .five, .six, .seven, .eight, .nine],
     [.two, .three, .four, .five, .six, .seven, .eight],
     [.ace, .two, .three, .four, .five, .six, .seven]]
    
    static func bonusPayout(bonus: Bonus) -> Int {
        switch bonus {
        case .none:
            return 0
        case .highCard:
            return 0
        case .pair:
            return 0
        case .twoPair:
            return 0
        case .trips:
            return 0
        case .straight:
            return 2
        case .flush:
            return 3
        case .fullHouse:
            return 5
        case .quads:
            return 25
        case .straightFlush:
            return 50
        case .royalFlush:
            return 100
        case .fiveOfAKind:
            return 200
        case .fiveAces:
            return 250
        case .sevenCardStraightFlush:
            return 500
        }
    }
}

struct LowHandRank: Comparable {
    var pairRank: CardRank?
    var ranks: [CardRank] = []
    
    static func < (lhs: LowHandRank, rhs: LowHandRank) -> Bool {
        
        if lhs.pairRank != nil && rhs.pairRank == nil {
            return false
        } else if lhs.pairRank == nil && rhs.pairRank != nil {
            return true
        } else if lhs.pairRank != nil && rhs.pairRank != nil {
            if lhs.pairRank! < rhs.pairRank! {
                return true
            } else if lhs.pairRank! > rhs.pairRank! {
                return false
            }
        }
        
        for i in 0...lhs.ranks.count - 1 {
            if lhs.ranks[i] > rhs.ranks[i] {
                return false
            } else if lhs.ranks[i] < rhs.ranks[i] {
                return true
            }
        }
        return true
    }
}

struct HighHandRank: Comparable {
    var bonus: Bonus = .none
    var cardRank: CardRank = .any
    var kickers: [Card] = []
    
    static func < (lhs: HighHandRank, rhs: HighHandRank) -> Bool {
        if lhs.bonus.caseIndex() < rhs.bonus.caseIndex() {
            return true
        } else if lhs.bonus.caseIndex() > rhs.bonus.caseIndex() {
            return false
        }
        
        if lhs.cardRank < rhs.cardRank {
            return true
        } else if lhs.cardRank > rhs.cardRank {
            return false
        } else {
            for i in 0...lhs.kickers.count - 1 {
                if lhs.kickers[i].rank > rhs.kickers[i].rank {
                    return false
                } else if lhs.kickers[i].rank < rhs.kickers[i].rank {
                    return true
                }
            }
            return true
        }
    }
}

class PGPBoard {
    func getHandFromCards(cards: [Card]) -> (PGPHand) {
        var hand = PGPHand()
        if cards.count == 7 {
            var freqDict: [CardRank: Int] = [:]
            //Get the frequency of each rank
            for card in cards {
                if let fequency = freqDict[card.rank] {
                    freqDict[card.rank] = fequency + 1
                } else {
                    freqDict[card.rank] = 1
                }
            }
            // Bucket the cards into pairs, trips and quads
            var pairs: [CardRank] = []
            var trips: [CardRank] = []
            var quads: [CardRank] = []
            for key in freqDict.keys {
                if let frequency = freqDict[key] {
                    if frequency >= 2 {
                        pairs.append(key)
                        
                        if let frequency = freqDict[key] {
                            if frequency >= 3 {
                                trips.append(key)
                            }
                        }
                        if let frequency = freqDict[key] {
                            if frequency == 4 {
                                quads.append(key)
                            }
                        }
                    }
                }
            }
            let hasJoker = cards.contains(where: {$0.rank == .joker})
            // Use the tuples to determine which rule to use to set the cards
            if !quads.isEmpty {
                //Set the hand based on quads
                return setQuadHand(quads, trips, cards, &hand, pairs, hasJoker: hasJoker)
            } else if !trips.isEmpty {
                // Set the hand based on trips
                return setTripsHand(&trips, cards, &hand, &pairs, hasJoker: hasJoker)
            } else if pairs.count >= 1 {
                pairs.sort(by: {$0 > $1})
                return setPairsHand(pairs, cards, &hand, hasJoker: hasJoker)
            } else {
                let sortedCards = cards.sorted(by: >)
                
                if hasJoker {
                    hand.low.append(sortedCards[1])
                    hand.low.append(sortedCards[3])
                } else {
                    hand.low.append(sortedCards[1])
                    hand.low.append(sortedCards[2])
                }
                hand.high = sortedCards.filter({!hand.low.contains($0)})
                
                var hands: [PGPHand] = []
                
                if let flushHand = self.getFlushHand(cards: cards, pairs: pairs) {
                    hands.append(flushHand)
                }
                if let straightHand = self.getStraightHand(cards: cards, hasJoker: hasJoker) {
                    hands.append(straightHand)
                }
                
                if let highestHand = self.getHighestHairHand(hands: hands) {
                    return highestHand
                }
                
                return hand
            }
        }
        return hand
    }
    
    fileprivate func setQuadHand(_ quads: [CardRank], _ trips: [CardRank], _ cards: [Card], _ hand: inout PGPHand, _ pairs: [CardRank], hasJoker: Bool) -> PGPHand {
        if let quadRank = quads.first {
            if hasJoker {
                if let pairRank = pairs.first(where: {$0 != quadRank}) {
                    if pairRank > quadRank {
                        let lowCards = cards.filter({$0.rank == pairRank})
                        hand.low = lowCards
                        hand.high = cards.filter({$0.rank == quadRank})
                        hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                        return hand
                    } else {
                        let quadCards = cards.filter({$0.rank == quadRank})
                        hand.low.append(quadCards[0])
                        hand.low.append(quadCards[1])
                        let highCards = cards.filter({!hand.low.contains($0)}).sorted(by: >)
                        hand.high = highCards
                        return hand
                    }
                } else {
                    let remainingCards = cards.filter({$0.rank != quadRank && $0.rank != .joker}).sorted(by: >)
                    if quadRank == .ace && remainingCards.first!.rank < .jack {
                        let quadsCards = cards.filter({$0.rank == quadRank})
                        hand.low.append(quadsCards[0])
                        hand.low.append(quadsCards[1])
                        hand.high = cards.filter({!hand.low.contains($0)})
                        return hand
                    } else {
                        if let lowCard = remainingCards.first {
                            hand.low.append(lowCard)
                            if let joker = cards.first(where: {$0.rank == .joker}) {
                                hand.low.append(joker)
                                let highCards = cards.filter({!hand.low.contains($0)})
                                hand.high = highCards
                                return hand
                            }
                        }
                    }
                }
            }
            // If there is trips and quads
            if trips.count > 1 {
                if let quadRank = quads.first {
                    if let tripRank = trips.first(where: {$0 != quadRank}) {
                        //According to Swift.org you cannot overload the ternary opperater
                        let highRank = Card.highestRank(firstRank: quadRank, secondRank: tripRank)
                        let lowCards = cards.filter({$0.rank == highRank})
                        hand.low.append(lowCards[0])
                        hand.low.append(lowCards[1])
                        
                        let highCards = cards.filter({!hand.low.contains($0)})
                        for highCard in highCards {
                            hand.high.append(highCard)
                        }
                        return hand
                    }
                }
            } else if pairs.count > 1 { // If there is pair and quads
                let lowRank = pairs.first(where: {$0 != quadRank})
                hand.low = cards.filter({$0.rank == lowRank})
                hand.high = cards.filter({$0.rank == quadRank})
                hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                return hand
            } else if quadRank >= CardRank.queen { // If A, K, Q
                // (A,Q,K are never played as quads unless there was already a pair)
                // Set the cards pair/pair
                let quadCards = cards.filter({$0.rank == quadRank})
                hand.low.append(quadCards[0])
                hand.low.append(quadCards[1])
                hand.high = [quadCards[2], quadCards[3]]
                hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                return hand
            } else if quadRank >= CardRank.nine && quadRank < CardRank.queen { // If J, 10, 9
                let nonQuads = cards.filter({$0.rank != quadRank}).sorted(by: >)
                // If there is a qualifying card
                if let qualCard = nonQuads.first(where: {$0.rank >= CardRank.king}) {
                    //Add the card to the low hand and then the highest remaining card in the nonQuads
                    hand.low.append(qualCard)
                    if let secondCard = nonQuads.first(where: {$0.rank != qualCard.rank}) {
                        hand.low.append(secondCard)
                    } else {
                        print("failed to get low card in quad \(quadRank)")
                        
                    }
                    hand.high = cards.filter({$0.rank == quadRank})
                    hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                    return hand
                } else { // Set the cards pair/pair
                    let quadCards = cards.filter({$0.rank == quadRank})
                    hand.low.append(quadCards[0])
                    hand.low.append(quadCards[1])
                    hand.high = [quadCards[2], quadCards[3]]
                    hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                    return hand
                }
            } else if quadRank >= CardRank.six && quadRank < CardRank.nine  { // If 8, 7, 6
                let nonQuads = cards.filter({$0.rank != quadRank}).sorted(by: >)
                // If there is a qualifying card
                if let qualCard = nonQuads.first(where: {$0.rank >= CardRank.queen}) {
                    //Add the card to the low hand and then the highest remaining card in the nonQuads
                    hand.low.append(qualCard)
                    if let secondCard = nonQuads.first(where: {$0.rank != qualCard.rank}) {
                        hand.low.append(secondCard)
                    } else {
                        print("failed to get low card in quad \(quadRank)")
                    }
                    hand.high = cards.filter({$0.rank == quadRank})
                    hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                    return hand
                } else { // Set the cards pair/pair
                    let quadCards = cards.filter({$0.rank == quadRank})
                    hand.low.append(quadCards[0])
                    hand.low.append(quadCards[1])
                    hand.high = [quadCards[2], quadCards[3]]
                    hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                    return hand
                }
            } else { // Set the cards quad behind
                // I'm sure there's a much better way to write this, and also to suffix the non quad card in the high hand
                let nonQuads = cards.filter({$0.rank != quadRank}).sorted(by: >)
                hand.low.append(nonQuads[0])
                hand.low.append(nonQuads[1])
                hand.high = cards.filter({$0.rank == quadRank})
                hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != quadRank}).sorted(by: >))
                return hand
            }
        }
        return hand
    }
    
    fileprivate func setTripsHand(_ trips: inout [CardRank], _ cards: [Card], _ hand: inout PGPHand, _ pairs: inout [CardRank], hasJoker: Bool) -> PGPHand {
        if trips.count == 2 {
            //Break the highest trips and play them at the top
            var bigTrips: [Card] = []
            if trips[0] > trips[1] {
                bigTrips = cards.filter({$0.rank == trips[0]})
                hand.low.append(bigTrips[0])
                hand.low.append(bigTrips[1])
                hand.high = cards.filter({$0.rank == trips[1]})
                hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) &&
                    !hand.high.contains($0)}).sorted(by: >))
                
            } else {
                bigTrips = cards.filter({$0.rank == trips[1]})
                hand.low.append(bigTrips[0])
                hand.low.append(bigTrips[1])
                hand.high = cards.filter({$0.rank == trips[0]})
                hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) &&
                    !hand.high.contains($0)}).sorted(by: >))
            }
            return hand
        } else {
            if pairs.count > 2 {
                var bigPairs: [Card] = []
                // Find the highest rank pair and play it at the top
                var rankedPairs = pairs.sorted(by: >)
                rankedPairs.removeAll(where: {$0 == trips.first!})
                bigPairs = cards.filter({$0.rank == rankedPairs[0]})
                hand.low.append(bigPairs[0])
                hand.low.append(bigPairs[1])
                hand.high = cards.filter({$0.rank == trips[0]})
                hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != trips[0]}).sorted(by: >))
                return hand
                //Full house
            } else if pairs.count > 1 {
                let singlePairRank = pairs.first(where: {$0 != trips[0]})
                let singlePairs = cards.filter({$0.rank == singlePairRank})
                if hasJoker {
                    if let soloCard = cards.first(where: {!pairs.contains($0.rank) && $0.rank != .joker}) {
                        //If we have the joker and the soloCard rank is higher than the pair rank place it and the joker on top
                        if soloCard.rank > singlePairRank! {
                            hand.low.append(cards.first(where: {$0.rank == .joker})!)
                            hand.low.append(soloCard)
                        } else {
                            hand.low.append(singlePairs[0])
                            hand.low.append(singlePairs[1])
                        }
                    }
                } else {
                    //Play the pair on the top
                    hand.low.append(singlePairs[0])
                    hand.low.append(singlePairs[1])
                }
                hand.high = cards.filter({$0.rank == trips[0]})
                hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != trips[0]}).sorted(by: >))
                return hand
            } else {
                // If Aces split and play with the highest non trip on top
                if trips[0] == .ace && !hasJoker {
                    let sortedCards = cards.sorted(by: >)
                    hand.low.append(sortedCards[0])
                    hand.low.append(sortedCards.first(where:{$0.rank != CardRank.ace})!)
                    hand.high.append(contentsOf: sortedCards.filter(
                        {!hand.low.contains($0)}).sorted(by: >))
                } else {
                    // Otherwise play the two highest non trip on top
                    let tripCards = cards.filter({$0.rank == trips[0]})
                    let remains = cards.filter({!tripCards.contains($0)}).sorted(by: >)
                    hand.low.append(remains[0])
                    hand.low.append(remains[1])
                    hand.high = tripCards
                    hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != trips[0]}).sorted(by: >))
                }
                
                var hands: [PGPHand] = []
                
                if let flushHand = self.getFlushHand(cards: cards, pairs: pairs) {
                    hands.append(flushHand)
                }
                if let straightHand = self.getStraightHand(cards: cards, hasJoker: hasJoker) {
                    hands.append(straightHand)
                }
                
                if let highestHand = self.getHighestHairHand(hands: hands) {
                    return highestHand
                }
            }
        }
        return hand
    }
    
    fileprivate func setPairsHand(_ pairs: [CardRank], _ cards: [Card], _ hand: inout PGPHand, hasJoker: Bool) -> PGPHand {
        if let highRank = pairs.first {
            let highPair = cards.filter({$0.rank == highRank})
            // Three pairs
            if pairs.count > 2 {
                // Set the high pair to the low
                hand.low.append(highPair[0])
                hand.low.append(highPair[1])
                if hasJoker {
                    hand.high = cards.filter({$0.rank == pairs[1]})
                    hand.high.append(cards.first(where: {$0.rank == .joker})!)
                    hand.high.append(contentsOf: cards.filter({$0.rank != pairs[1] && !hand.low.contains($0) && $0.rank != .joker}).sorted(by: >))
                } else {
                    hand.high = cards.filter({$0.rank == pairs[1]})
                    hand.high.append(contentsOf: cards.filter({$0.rank == pairs[2]}))
                    hand.high.append(contentsOf: cards.filter({$0.rank != pairs[1] && $0.rank != pairs[2] && !hand.low.contains($0)}).sorted(by: >))
                }
                return hand
                // Two pairs
            } else if pairs.count > 1 {
                if hasJoker {
                    let sortedCards = cards.sorted(by: >)
                    let highCard = sortedCards[1]
                    //Play the natural high pair on top
                    if pairs.contains(highCard.rank) {
                        hand.low.append(highCard)
                        hand.low.append(cards.first(where: {$0.rank == highCard.rank && $0.suit != highCard.suit})!)
                        // Here we want high hand to be the low pair, joker, remaining cards
                        hand.high = cards.filter({$0.rank == pairs[1]})
                        hand.high.append(contentsOf: cards.filter({$0.rank != pairs[1] && !hand.low.contains($0)}).sorted(by: >))
                        return hand
                    //Play highest card with joker on top
                    } else {
                        hand.low.append(highCard)
                        hand.low.append(cards.first(where: { $0.rank == .joker})!)
                        // Here we want the high hand to be two pairs then the remaining cards
                        hand.high = cards.filter({$0.rank == pairs[0]})
                        hand.high.append(contentsOf: cards.filter({$0.rank == pairs[1]}))
                        hand.high.append(contentsOf: cards.filter({$0.rank != pairs[0] && $0.rank != pairs[1] && !hand.low.contains($0)}))
                        return hand
                    }
                } else {
                    if highRank >= CardRank.queen {
                        // Set the low pair to the low
                        let lowRank = pairs[1]
                        let lowPair = cards.filter({$0.rank == lowRank})
                        hand.low.append(lowPair[0])
                        hand.low.append(lowPair[1])
                        hand.high = highPair
                        hand.high.append(contentsOf: cards.filter({!hand.low.contains($0) && $0.rank != highRank}).sorted(by: >))
                        return hand
                    } else if highRank >= CardRank.nine {
                        if let qualCard = cards.first(where:{$0.rank == CardRank.ace}) {
                            let sortedCards = cards.sorted(by: >)
                            if let secondCard = sortedCards.first(where: {$0 != qualCard &&
                                !pairs.contains($0.rank)}) {
                                hand.low.append(qualCard)
                                hand.low.append(secondCard)
                                var cardPairs = cards.filter({$0.rank == pairs[0]})
                                cardPairs.append(contentsOf: cards.filter({$0.rank == pairs[1]}))
                                hand.high = cardPairs
                                hand.high.append(contentsOf: cards.filter({!cardPairs.contains($0) && !hand.low.contains($0)}))
                            } else {
                                print("Could not find second card in two pair")
                            }
                            return hand
                        } else {
                            // Set the low pair to the low
                            let sortedCards = cards.sorted(by: >)
                            let lowRank = pairs[1]
                            let lowPair = sortedCards.filter({$0.rank == lowRank})
                            hand.low.append(lowPair[0])
                            hand.low.append(lowPair[1])
                            hand.high.append(contentsOf: sortedCards.filter({$0.rank == pairs[0]}))
                            hand.high.append(contentsOf: sortedCards.filter({$0.rank != pairs[0] && !hand.low.contains($0)}))
                            return hand
                        }
                    } else if highRank >= CardRank.six {
                        if let qualCard = cards.first(where:{$0.rank >= CardRank.king}) {
                            let sortedCards = cards.sorted(by: >)
                            if let secondCard = sortedCards.first(where: {$0 != qualCard &&
                                !pairs.contains($0.rank)}) {
                                hand.low.append(qualCard)
                                hand.low.append(secondCard)
                                var cardPairs = cards.filter({$0.rank == pairs[0]})
                                cardPairs.append(contentsOf: cards.filter({$0.rank == pairs[1]}))
                                hand.high = cardPairs
                                hand.high.append(contentsOf: cards.filter({!cardPairs.contains($0) && !hand.low.contains($0)}))
                            } else {
                                print("Could not find second card in two pair")
                            }
                            return hand
                        } else {
                            // Set the low pair to the low
                            let sortedCards = cards.sorted(by: >)
                            let lowRank = pairs[1]
                            let lowPair = sortedCards.filter({$0.rank == lowRank})
                            hand.low.append(lowPair[0])
                            hand.low.append(lowPair[1])
                            hand.high.append(contentsOf: sortedCards.filter({$0.rank == pairs[0]}))
                            hand.high.append(contentsOf: sortedCards.filter({$0.rank != pairs[0] && !hand.low.contains($0)}))
                            return hand
                        }
                    } else {
                        if let qualCard = cards.first(where:{$0.rank >= CardRank.queen}) {
                            let sortedCards = cards.sorted(by: >)
                            if let secondCard = sortedCards.first(where: {$0 != qualCard &&
                                !pairs.contains($0.rank)}) {
                                hand.low.append(qualCard)
                                hand.low.append(secondCard)
                                var cardPairs = cards.filter({$0.rank == pairs[0]})
                                cardPairs.append(contentsOf: cards.filter({$0.rank == pairs[1]}))
                                hand.high = cardPairs
                                hand.high.append(contentsOf: cards.filter({!cardPairs.contains($0) && !hand.low.contains($0)}))
                            } else {
                                print("Could not find second card in two pair")
                            }
                            return hand
                        } else {
                            // Set the low pair to the low
                            let sortedCards = cards.sorted(by: >)
                            let lowRank = pairs[1]
                            let lowPair = sortedCards.filter({$0.rank == lowRank})
                            hand.low.append(lowPair[0])
                            hand.low.append(lowPair[1])
                            hand.high.append(contentsOf: sortedCards.filter({$0.rank == pairs[0]}))
                            hand.high.append(contentsOf: sortedCards.filter({$0.rank != pairs[0] && !hand.low.contains($0)}))
                            return hand
                        }
                    }
                }
                // One pair
            } else {
                let sortedCards = cards.sorted(by: >)
                if let firstCard = sortedCards.first(where: {!pairs.contains($0.rank)}) {
                    if let secondCard = sortedCards.first(where: {!pairs.contains($0.rank) && $0 != firstCard}) {
                        if hasJoker && secondCard.rank > pairs.first! {
                            let pairs = cards.filter({$0.rank == pairs.first!})
                            hand.low.append(pairs[0])
                            hand.low.append(pairs[1])
                            //!! This needs to be high card, joker, remaing cards
                            hand.high.append(sortedCards.first(where: {$0.rank != .joker})!)
                            hand.high.append(sortedCards.first(where: {$0.rank == .joker})!)
                            let remainingCards = sortedCards[2...6].filter({!hand.low.contains($0)})
                            hand.high.append(contentsOf: remainingCards)
                        } else {
                            hand.low.append(firstCard)
                            hand.low.append(secondCard)
                            hand.high = sortedCards.filter({$0.rank == pairs[0]})
                            hand.high.append(contentsOf: sortedCards.filter({$0.rank != pairs[0] && !hand.low.contains($0)}))
                        }
                    }
                }
                
                var hands: [PGPHand] = []
                
                if hasJoker {
                    hands.append(hand)
                }
                
                if let flushHand = self.getFlushHand(cards: cards, pairs: pairs) {
                    hands.append(flushHand)
                }
                if let straightHand = self.getStraightHand(cards: cards, hasJoker: hasJoker) {
                    hands.append(straightHand)
                }
                
                if let highestHand = self.getHighestHairHand(hands: hands) {
                    return highestHand
                }
                
                return hand
            }
        } else {
            print("Failed to evaluate pairs")
            return hand
        }
    }
    
    func getStraightHand(cards: [Card], hasJoker: Bool) -> PGPHand? {
        var hands: [PGPHand] = []
        var ranks: [CardRank] = []
        
        if cards.count == 0 {
            return nil
        }
        
        for card in cards {
            ranks.append(card.rank)
        }
        
        let rankSet: Set<CardRank> = Set(ranks)
        
        for straightSet in PGPHand.straightHands {
            let intesection = rankSet.intersection(straightSet)
            var hand = PGPHand()
            if intesection.count == 4 && hasJoker {
                hand.high.append(cards.first(where: {$0.rank == .joker})!)
                for rank in intesection {
                    hand.high.append(cards.first(where: {$0.rank == rank})!)
                }
                
                hand.high.sort(by: <)
                //!! Five high straight does not sort correctly using this
                hand.low = cards.filter({!hand.high.contains($0)}).sorted(by: >)
                hands.append(hand)
            } else if intesection.count == 5 {
                for rank in straightSet {
                    hand.high.append(cards.first(where: {$0.rank == rank})!)
                }
                
                hand.high.sort(by: <)
                //!! Five high straight does not sort correctly using this
                hand.low = cards.filter({!hand.high.contains($0)}).sorted(by: >)
                hands.append(hand)
            }
        }
        
        if let bestHand = self.getHighestHairHand(hands: hands) {
            return bestHand
        }
        return nil
    }
    
    
    func getFlushHand(cards: [Card], pairs: [CardRank]) -> PGPHand? {
        var flushDict: [Card.CardSuit: Int] = [:]
        var hasJoker = false
        for card in cards {
            if let frequency = flushDict[card.suit] {
                flushDict[card.suit]! = frequency + 1
            } else {
                flushDict[card.suit] = 1
            }
            if card.rank == .joker {
                hasJoker = true
            }
        }
        
        for key in flushDict.keys {
            if let frequency = flushDict[key] {
                var hand = PGPHand()
                let suitedCards = cards.filter({$0.suit == key}).sorted(by: >)
                if frequency >= 5 {
                    if frequency == 7 {
                        hand.low.append(suitedCards.first!)
                        hand.low.append(suitedCards[1])
                        let highCards = suitedCards.filter({!hand.low.contains($0)})
                        hand.high = self.setFlushHighHand(cards: highCards)
                        return hand
                    } else if frequency == 6 {
                        if !pairs.isEmpty {
                            hand.low.append(cards.first(where: {$0.rank == pairs.first!})!)
                            hand.low.append(cards.first(where: {$0 != hand.low.first! && $0.rank == pairs.first})!)
                            let highCards = suitedCards.filter({!hand.low.contains($0)})
                            hand.high = self.setFlushHighHand(cards: highCards)
                            return hand
                        } else {
                            let unsuitedCards = cards.filter({!suitedCards.contains($0)})
                            let sortedCards = cards.sorted(by: >)
                            var low:[Card] = [unsuitedCards.first!, suitedCards.first!]
                            low.sort(by: >)
                            hand.low.append(low[0])
                            hand.low.append(low[1])
                            let highCards = suitedCards.filter({!hand.low.contains($0)})
                            hand.high = self.setFlushHighHand(cards: highCards)
                            return hand
                        }
                    } else if frequency == 5 {
                        if !pairs.isEmpty {
                            if !suitedCards.contains(where: {$0.rank == pairs.first!}) {
                                hand.low.append(cards.first(where: {$0.rank == pairs.first!})!)
                                hand.low.append(cards.first(where: {$0.rank == pairs.first! && $0 != hand.low.first!})!)
                                let highCards = suitedCards.filter({!hand.low.contains($0)})
                                hand.high = self.setFlushHighHand(cards: highCards)
                                return hand
                            } else {
                                let unsuitedCards = cards.filter({!suitedCards.contains($0)})
                                hand.low = unsuitedCards
                                hand.high = suitedCards
                                return hand
                            }
                        } else {
                            let unsuitedCards = cards.filter({!suitedCards.contains($0)})
                            hand.low = unsuitedCards
                            hand.high = suitedCards
                            
                            return hand
                        }
                    }
                } else if frequency == 4 && hasJoker {
                    var highCards = suitedCards
                    highCards.append(cards.first(where: {$0.rank == .joker})!)
                    hand.high = self.setFlushHighHand(cards: highCards)
                    hand.low = cards.filter({!hand.high.contains($0)})
                    return hand
                }
            }
        }
        return nil
    }
    
    // Consider using lowHandEvaluation to rewrite this function
    func getHighestHairHand(hands: [PGPHand]) -> PGPHand? {
        var highHand: PGPHand?
        var pairRank: CardRank?
        var highestRank: CardRank?
        
        if hands.count == 0 {
            return nil
        }
        
        if hands.count == 1 {
            return hands.first
        }
        
        for hand in hands {
            if hand.low[0].rank == hand.low[1].rank {
                if pairRank != nil {
                    if hand.low[0].rank > pairRank! {
                        pairRank = hand.low[0].rank
                        highHand = hand
                    }
                } else {
                    pairRank = hand.low[0].rank
                    highHand = hand
                }
            } else if hand.low.first(where: {$0.rank == .joker}) != nil {
                if let secondCard = hand.low.first(where: {$0.rank != .joker}) {
                    if pairRank != nil {
                        if secondCard.rank > pairRank! {
                            pairRank = hand.low[0].rank
                            highHand = hand
                        }
                    } else {
                        pairRank = secondCard.rank
                        highHand = hand
                    }
                }
            } else {
                if let highCard = hand.low.sorted(by: >).first {
                    if highestRank != nil {
                        if highCard.rank > highestRank! && pairRank == nil {
                            highestRank = highCard.rank
                            highHand = hand
                        } else if highCard.rank == highestRank! && pairRank == nil {
                            if hand.low[1] > highHand!.low[1] {
                                highHand = hand
                            }
                        }
                    } else if pairRank == nil {
                        highestRank = highCard.rank
                        highHand = hand
                    }
                }
            }
        }
        return highHand
    }
    
    func getBonusForCards(cards: [Card]) -> Bonus {
        let bonus: Bonus = .highCard
        
        let hasJoker = cards.contains(where: {$0.rank == .joker})
        
        var flushSuit: Card.CardSuit? = nil
        var has7CardFlush = false
        var hasStraight = false
        
        var flushDict: [Card.CardSuit: Int] = [:]
        for card in cards {
            if let frequency = flushDict[card.suit] {
                flushDict[card.suit]! = frequency + 1
            } else {
                flushDict[card.suit] = 1
            }
        }
        
        for key in flushDict.keys {
            if let frequency = flushDict[key] {
                if frequency == 7 {
                    flushSuit = key
                    has7CardFlush = true
                } else if frequency == 6 {
                    flushSuit = key
                    if hasJoker {
                        has7CardFlush = true
                        break
                    }
                    break
                } else if frequency == 5 {
                    flushSuit = key
                    break
                } else if frequency == 4 && hasJoker {
                    flushSuit = key
                    break
                }
            }
        }
        
        var ranks: [CardRank] = []
        for card in cards {
            ranks.append(card.rank)
        }
        
        let rankSet: Set<CardRank> = Set(ranks)
        
        if rankSet.count == 7 {
            for straightSet in PGPHand.sevenCardStraightHands {
                let intesection = rankSet.intersection(straightSet)
                if intesection.count == 7 {
                    if has7CardFlush {
                        return .sevenCardStraightFlush
                    }
                } else if intesection.count == 6 && hasJoker {
                    if has7CardFlush {
                        return .sevenCardStraightFlush
                    }
                }
            }
        }
        
        var freqDict: [CardRank: Int] = [:]
        //Get the frequency of each rank
        for card in cards {
            if let fequency = freqDict[card.rank] {
                freqDict[card.rank] = fequency + 1
            } else {
                freqDict[card.rank] = 1
            }
        }
        // Bucket the cards into pairs, trips and quads
        var pairs: [CardRank] = []
        var trips: [CardRank] = []
        var quads: [CardRank] = []
        for key in freqDict.keys {
            if let frequency = freqDict[key] {
                if frequency >= 2 {
                    pairs.append(key)
                    
                    if let frequency = freqDict[key] {
                        if frequency >= 3 {
                            trips.append(key)
                        }
                    }
                    if let frequency = freqDict[key] {
                        if frequency == 4 {
                            quads.append(key)
                        }
                    }
                }
            }
        }
        
        if !quads.isEmpty {
            if hasJoker {
                if quads.first == .ace {
                    return .fiveAces
                } else {
                    return .fiveOfAKind
                }
            }
            return .quads
        }
        
        //Royal and straight flush check, flag straights
        if rankSet.count >= 4 {
            for straightSet in PGPHand.straightHands {
                let intesection = rankSet.intersection(straightSet)
                if intesection.count == 5 {
                    if flushSuit != nil {
                        let flushHand = cards.filter({$0.suit == flushSuit && intesection.contains($0.rank)})
                        // Check if all of the straight cards are the same suit
                        if flushHand.count == 5 {
                            if straightSet.sorted().first == .ten {
                                return .royalFlush
                            } else {
                                return .straightFlush
                            }
                        }
                    }
                    hasStraight = true
                } else if intesection.count == 4 && hasJoker {
                    if flushSuit != nil {
                        let flushHand = cards.filter({$0.suit == flushSuit && intesection.contains($0.rank)})
                        // Check if all of the straight cards are the same suit
                        if flushHand.count == 4 {
                            if straightSet.sorted().first == .ten {
                                return .royalFlush
                            } else {
                                return .straightFlush
                            }
                        }
                    }
                    hasStraight = true
                }
            }
        }
        
        // After royal and straight flush check we check hands with trips and lower
        if !trips.isEmpty && hasJoker {
            return .quads
        }
        
        if !trips.isEmpty && pairs.count >= 2 {
            return .fullHouse
        }
        
        if pairs.count >= 2 && hasJoker {
            return .fullHouse
        }
        
        if flushSuit != nil {
            return .flush
        }
        
        if hasStraight {
            return .straight
        }
        
        if !trips.isEmpty || (!pairs.isEmpty && hasJoker) {
            return .trips
        }
        
        if pairs.count == 2 || (pairs.count == 1 && hasJoker) {
            return .twoPair
        }
        
        if pairs.count == 1 || hasJoker {
            return .pair
        }
        
        return bonus
    }
    
    func getHandComparison(dealerHand: PGPHand, playerHand: PGPHand) -> HandStatus {
        var lowStatus: HandStatus = .lose
        var highStatus: HandStatus = .lose

        let dealerLowHandRank = self.getLowHandRank(cards: dealerHand.low)
        let playerLowHandRank = self.getLowHandRank(cards: playerHand.low)
        
        if dealerLowHandRank > playerLowHandRank {
            lowStatus = .lose
        } else if dealerLowHandRank < playerLowHandRank {
            lowStatus = .win
        } else {
            lowStatus = .push
        }
        
        let dealerHighHandRank = getHighHandRank(cards: dealerHand.high)
        let playerHighHandRank = getHighHandRank(cards: playerHand.high)
        
        if dealerHighHandRank > playerHighHandRank {
            highStatus = .lose
        } else if dealerHighHandRank < playerHighHandRank {
            highStatus = .win
        } else {
            highStatus = .push
        }
        
        
        if lowStatus == .lose && highStatus == .lose {
            return .lose
        } else if lowStatus == .win && highStatus == .win {
            return .win
        } else {
            return .push
        }
    }
    
    func getLowHandRank(cards: [Card]) -> LowHandRank {
        var lowHandRank = LowHandRank()
        if cards.count == 2 {
            if cards[0].rank == cards[1].rank {
                lowHandRank.pairRank = cards[0].rank
            } else if cards.contains(where: {$0.rank == .joker}) {
                lowHandRank.pairRank = cards.first(where: {$0.rank != .joker})!.rank
            }
            lowHandRank.ranks = [cards[0].rank, cards[1].rank].sorted(by: >)
        }
        return lowHandRank
    }
    
    func getHighHandRank(cards: [Card]) -> HighHandRank {
        var highHandRank = HighHandRank()
        highHandRank.bonus = .none
        highHandRank.cardRank = .joker
        highHandRank.kickers = []
        
        let hasJoker = cards.contains(where: {$0.rank == .joker})
        
        var freqDict: [CardRank: Int] = [:]
        //Get the frequency of each rank
        for card in cards {
            if let fequency = freqDict[card.rank] {
                freqDict[card.rank] = fequency + 1
            } else {
                freqDict[card.rank] = 1
            }
        }
        // Bucket the cards into pairs, trips and quads
        var pairs: [CardRank] = []
        var trips: [CardRank] = []
        var quads: [CardRank] = []
        for key in freqDict.keys {
            if let frequency = freqDict[key] {
                if frequency >= 2 {
                    pairs.append(key)
                    
                    if let frequency = freqDict[key] {
                        if frequency >= 3 {
                            trips.append(key)
                        }
                    }
                    if let frequency = freqDict[key] {
                        if frequency == 4 {
                            quads.append(key)
                        }
                    }
                }
            }
        }
        
        highHandRank.bonus = getBonusForCards(cards: cards)
        
        switch highHandRank.bonus {
        case .none:
            highHandRank.cardRank = cards.sorted(by: >).first!.rank
            highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
        case .highCard:
            highHandRank.cardRank = cards.sorted(by: >).first!.rank
            highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
        case .pair:
            if hasJoker {
                highHandRank.cardRank = cards.filter({$0.rank != .joker}).sorted(by: >).first!.rank
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank && $0.rank != .joker}).sorted(by: >)
            } else {
                highHandRank.cardRank = pairs.sorted(by: >).first!
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
            }
        case .twoPair:
            //If you have two natural pairs and a joker you have a full house, if you have a pair and joker you have trips
            highHandRank.cardRank = pairs.sorted(by: >).first!
            highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
        case .trips:
            if hasJoker {
                highHandRank.cardRank = pairs.sorted(by: >).first!
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank && $0.rank != .joker}).sorted(by: >)
            } else {
                highHandRank.cardRank = trips.first!
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
            }
        case .straight:
            let sortedCards = cards.sorted(by: >)
            if hasJoker {
                if sortedCards[0].rank == .joker {
                    //Wheel check
                    if sortedCards.contains(where: {$0.rank == .ace}) {
                        if sortedCards.contains(where: {$0.rank >= .ten && $0.rank != .ace && $0.rank != .joker}) {
                            highHandRank.cardRank = .ace
                        } else {
                            highHandRank.cardRank = .five
                        }
                    } else {
                        highHandRank.cardRank = Card.incrementRank(rank: sortedCards[1].rank)
                    }
                } else {
                    //Wheel check
                    if sortedCards.contains(where: {$0.rank == .ace}) {
                        if sortedCards.contains(where: {$0.rank >= .ten && $0.rank != .ace}) {
                            highHandRank.cardRank = .ace
                        } else {
                            highHandRank.cardRank = .five
                        }
                    } else {
                        highHandRank.cardRank = sortedCards[0].rank
                    }
                }
            } else {
                highHandRank.cardRank = sortedCards[0].rank
            }
        case .flush:
            if hasJoker {
                //What rank does the joker play as? Probably better ways to write this
                if cards.contains(where: {$0.rank == .ace}) {
                    if cards.contains(where: {$0.rank == .king}) {
                        if cards.contains(where: {$0.rank == .queen}) {
                            highHandRank.cardRank = .jack
                            //If we have A,K,Q,J already in a flush, it's no longer just a flush
                        } else {
                            highHandRank.cardRank = .queen
                        }
                    } else {
                        highHandRank.cardRank = .king
                    }
                } else {
                    highHandRank.cardRank = .ace
                }
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank && $0.rank != .joker}).sorted(by: >)
            } else {
                highHandRank.cardRank = cards.sorted(by: >).first!.rank
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
            }
        case .fullHouse:
            if hasJoker {
                highHandRank.cardRank = pairs.sorted(by: >).first!
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank && $0.rank != .joker}).sorted(by: >)
            } else {
                highHandRank.cardRank = trips.first!
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
            }
        case .quads:
            if hasJoker {
                highHandRank.cardRank = trips.first!
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank && $0.rank != .joker}).sorted(by: >)
            } else {
                highHandRank.cardRank = quads.first!
                highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
            }
        case .straightFlush:
            let sortedCards = cards.sorted(by: >)
            if hasJoker {
                if sortedCards[0].rank == .joker {
                    //Wheel check
                    if sortedCards.contains(where: {$0.rank == .ace}) {
                        if sortedCards.contains(where: {$0.rank >= .ten && $0.rank != .ace && $0.rank != .joker}) {
                            highHandRank.cardRank = .ace
                        } else {
                            highHandRank.cardRank = .five
                        }
                    } else {
                        highHandRank.cardRank = Card.incrementRank(rank: sortedCards[1].rank)
                    }
                } else {
                    //Wheel check
                    if sortedCards.contains(where: {$0.rank == .ace}) {
                        if sortedCards.contains(where: {$0.rank >= .ten && $0.rank != .ace}) {
                            highHandRank.cardRank = .ace
                        } else {
                            highHandRank.cardRank = .five
                        }
                    } else {
                        highHandRank.cardRank = sortedCards[0].rank
                    }
                }
            } else {
                highHandRank.cardRank = sortedCards[0].rank
            }
        case .royalFlush:
            highHandRank.cardRank = .ace
        case .fiveOfAKind:
            highHandRank.cardRank = cards.filter({$0.rank != .joker}).sorted(by: >).first!.rank
        case .fiveAces:
            highHandRank.cardRank = .ace
        default:
            highHandRank.cardRank = cards.sorted(by: >).first!.rank
            highHandRank.kickers = cards.filter({$0.rank != highHandRank.cardRank}).sorted(by: >)
        }
        
        return highHandRank
    }
    
    func setFlushHighHand(cards: [Card]) -> [Card] {
        var sortedCards = cards.sorted(by: >)
        if let joker = cards.first(where: { $0.rank == .joker }) {
            let jokerOffset = cards.firstIndex(where: {$0.rank == .joker})! + 1
            if cards[0].rank == .ace {
                if cards[1].rank == .king {
                    if cards[1].rank == .queen {
                        if cards[1].rank == .jack {
                            sortedCards.move(fromOffsets: IndexSet(integer: jokerOffset), toOffset: 4)
                        } else {
                            sortedCards.move(fromOffsets: IndexSet(integer: jokerOffset), toOffset: 3)
                        }
                    } else {
                        sortedCards.move(fromOffsets: IndexSet(integer: jokerOffset), toOffset: 2)
                    }
                } else {
                    sortedCards.move(fromOffsets: IndexSet(integer: jokerOffset), toOffset: 1)
                }
            } else {
                sortedCards.move(fromOffsets: IndexSet(integer: jokerOffset), toOffset: 0)
            }
        }
        return sortedCards
    }
}

