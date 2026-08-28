//
//  Card.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation

enum CardRank: CaseIterable, Comparable {
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
    case joker
    case any
    
    static func rank(value: Int) -> CardRank {
        switch value {
        case 1:
            return .ace
        case 2:
            return .two
        case 3:
            return .three
        case 4:
            return .four
        case 5:
            return .five
        case 6:
            return .six
        case 7:
            return .seven
        case 8:
            return .eight
        case 9:
            return .nine
        case 10:
            return .ten
        case 11:
            return .jack
        case 12:
            return .queen
        case 13:
            return .king
        case 14:
            return .ace
        case 15:
            return .joker
        default:
            return .any
        }
    }
}

struct Card: Hashable {
    enum CardSuit: Int, CaseIterable {
        case spades = 0
        case clubs = 1
        case diamonds = 2
        case hearts = 3
        case any = 4
        
    }
    
    static func validSuits() -> [CardSuit] {
        return [CardSuit.spades, CardSuit.clubs, CardSuit.diamonds, CardSuit.hearts]
    }
    
    static func validRanks() -> [CardRank] {
        return [CardRank.two,
                CardRank.three,
                CardRank.four,
                CardRank.five,
                CardRank.six,
                CardRank.seven,
                CardRank.eight,
                CardRank.nine,
                CardRank.ten,
                CardRank.jack,
                CardRank.queen,
                CardRank.king,
                CardRank.ace,
        ]
    }
    
    var rank: CardRank
    var suit: CardSuit
    
    init(rank: CardRank, suit: CardSuit) {
        self.rank = rank
        self.suit = suit
    }
    
    init(rank: Int, suit: Int) {
        self.rank = CardRank.rank(value: rank)
        self.suit = CardSuit.init(rawValue: suit) ?? CardSuit.any
    }
    
    func description() -> String {
        var rankText: String = ""
        var suitText: String = ""
        
        switch self.rank {
            
        case .two:
            rankText = "2"
        case .three:
            rankText = "3"
        case .four:
            rankText = "4"
        case .five:
            rankText = "5"
        case .six:
            rankText = "6"
        case .seven:
            rankText = "7"
        case .eight:
            rankText = "8"
        case .nine:
            rankText = "9"
        case .ten:
            rankText = "10"
        case .jack:
            rankText = "J"
        case .queen:
            rankText = "Q"
        case .king:
            rankText = "K"
        case .ace:
            rankText = "A"
        case .joker:
            rankText = "$"
        case .any:
            rankText = "JO"
        }
        
        switch self.suit {
            
        case .spades:
            suitText = "♠️"
        case .clubs:
            suitText = "♣️"
        case .diamonds:
            suitText = "♦️"
        case .hearts:
            suitText = "♥️"
        case .any:
            suitText = "⚪️"
        }
        
        return rankText + suitText
    }
    
    static func lowestRank(firstRank: CardRank, secondRank: CardRank) -> CardRank {
        if firstRank < secondRank {
            return firstRank
        } else {
            return secondRank
        }
    }
    
    static func highestRank(firstRank: CardRank, secondRank: CardRank) -> CardRank {
        if firstRank > secondRank {
            return firstRank
        } else {
            return secondRank
        }
    }
    
    static func incrementRank(rank: CardRank) -> CardRank {
        switch rank {
        case .two:
            return .three
        case .three:
            return .four
        case .four:
            return .five
        case .five:
            return .six
        case .six:
            return .seven
        case .seven:
            return .eight
        case .eight:
            return .nine
        case .nine:
            return .ten
        case .ten:
            return .jack
        case .jack:
            return .queen
        case .queen:
            return  .king
        case .king:
            return .ace
        case .ace:
            return .ace
        case .joker:
            return .joker
        case .any:
            return .any
        }
    }
}


extension Card: Comparable {
    static func <(lhs: Card, rhs: Card) -> Bool {
        lhs.rank < rhs.rank
    }
}
