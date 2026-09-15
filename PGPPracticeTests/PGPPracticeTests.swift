//
//  PGPPracticeTests.swift
//  PGPPracticeTests
//
//  Created by Ahmed Browne on 10/6/25.
//

import Testing
@testable import PGPPractice

struct PGPPracticeTests {
    

    
//    override class func setUp() {
//        super.setUp()
//        
//    }

    @Test mutating func paiGowHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .six, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .nine, suit: .hearts), Card(rank: .eight, suit: .clubs)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .six, suit: .diamonds),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .three, suit: .spades),
                                        Card(rank: .two, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func onePairHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .six, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .nine, suit: .hearts)],
                                 high: [Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .spades),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .six, suit: .diamonds),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPairA_K_Q_HandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .queen, suit: .diamonds),
                     Card(rank: .ace, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .two, suit: .hearts), Card(rank: .two, suit: .spades)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .queen, suit: .diamonds),
                                        Card(rank: .ace, suit: .hearts),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPairJ_10_9_KickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .jack, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .jack, suit: .diamonds),
                     Card(rank: .ace, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .ace, suit: .hearts), Card(rank: .eight, suit: .clubs)],
                                 high: [Card(rank: .jack, suit: .hearts),
                                        Card(rank: .jack, suit: .diamonds),
                                        Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .spades),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPairJ_10_9_NoKickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .jack, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .jack, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .two, suit: .hearts), Card(rank: .two, suit: .spades)],
                                 high: [Card(rank: .jack, suit: .hearts),
                                        Card(rank: .jack, suit: .diamonds),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPair8_7_6_KickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .king, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .king, suit: .hearts), Card(rank: .seven, suit: .clubs)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .diamonds),
                                        Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .spades),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPair8_7_6_NoKickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .two, suit: .hearts), Card(rank: .two, suit: .spades)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .diamonds),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .seven, suit: .clubs),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPair5_4_3_KickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .five, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .five, suit: .clubs)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .spades),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPair5_4_3_NoKickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .two, suit: .hearts), Card(rank: .two, suit: .spades)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .seven, suit: .clubs),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func threePairHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .nine, suit: .spades),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .nine, suit: .spades), Card(rank: .nine, suit: .hearts)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .spades),
                                        Card(rank: .seven, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func tripsHandAceNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .five, suit: .hearts),
                     Card(rank: .ace, suit: .hearts),
                     Card(rank: .ace, suit: .spades),
                     Card(rank: .ace, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        //!! Sorted inconsistently
        let answerHand = PGPHand(low: [Card(rank: .ace, suit: .hearts), Card(rank: .nine, suit: .hearts)],
                                 high: [Card(rank: .ace, suit: .spades),
                                        Card(rank: .ace, suit: .diamonds),
                                        Card(rank: .seven, suit: .clubs),
                                        Card(rank: .five, suit: .hearts),
                                        Card(rank: .two, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func tripsHandNoAceNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .five, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        //!! Sorted inconsistently
        let answerHand = PGPHand(low: [Card(rank: .nine, suit: .hearts), Card(rank: .seven, suit: .clubs)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .spades),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .five, suit: .hearts),
                                        Card(rank: .two, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoTripsHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .five, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .five, suit: .spades),
                     Card(rank: .five, suit: .clubs),
                     Card(rank: .two, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .five, suit: .hearts), Card(rank: .five, suit: .spades)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .spades),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .five, suit: .clubs),
                                        Card(rank: .two, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func straightHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .nine, suit: .spades),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .five, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .nine, suit: .spades), Card(rank: .seven, suit: .clubs)],
                                 high: [Card(rank: .two, suit: .hearts),
                                        Card(rank: .three, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .five, suit: .spades),
                                        Card(rank: .six, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .hearts)]
        
        //!! Also ordered inconsistently
        let answerHand = PGPHand(low: [Card(rank: .three, suit: .spades), Card(rank: .eight, suit: .clubs)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .two, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func straightOnePairCompleteHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .jack, suit: .clubs),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .five, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .jack, suit: .spades), Card(rank: .jack, suit: .clubs)],
                                 high: [Card(rank: .two, suit: .hearts),
                                        Card(rank: .three, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .five, suit: .spades),
                                        Card(rank: .six, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func straightOnePairIncompleteHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .five, suit: .spades),
                     Card(rank: .jack, suit: .clubs),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .five, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .jack, suit: .clubs), Card(rank: .five, suit: .diamonds)],
                                 high: [Card(rank: .two, suit: .hearts),
                                        Card(rank: .three, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .five, suit: .spades),
                                        Card(rank: .six, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushOnePairCompleteHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .hearts)]
        
        //!! Also ordered inconsistently
        let answerHand = PGPHand(low: [Card(rank: .eight, suit: .spades), Card(rank: .eight, suit: .clubs)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .two, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushOnePairIncompleteHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .queen, suit: .spades),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .two, suit: .hearts)]
        
        //!! Also ordered inconsistently with the test above
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .spades), Card(rank: .eight, suit: .clubs)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .two, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }

    @Test mutating func straightTwoPairCompleteHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .two, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .spades),
                     Card(rank: .five, suit: .spades)]
        
        let answerHand = PGPHand(low: [Card(rank: .two, suit: .hearts), Card(rank: .two, suit: .spades)],
                                 high: [Card(rank: .six, suit: .clubs),
                                        Card(rank: .six, suit: .spades),
                                        Card(rank: .five, suit: .spades),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .three, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushTwoPairCompleteHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .five, suit: .hearts),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .five, suit: .clubs),
                     Card(rank: .seven, suit: .hearts)]
        
        //!! Also ordered inconsistently
        let answerHand = PGPHand(low: [Card(rank: .four, suit: .hearts), Card(rank: .four, suit: .spades)],
                                 high: [Card(rank: .five, suit: .hearts),
                                        Card(rank: .five, suit: .clubs),
                                        Card(rank: .eight, suit: .hearts),
                                        Card(rank: .seven, suit: .hearts),
                                        Card(rank: .six, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func fullHouseHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .two, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .spades),
                     Card(rank: .two, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .six, suit: .clubs), Card(rank: .six, suit: .spades)],
                                 high: [Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .spades),
                                        Card(rank: .two, suit: .diamonds),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .three, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func fullHousePairHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .two, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .six, suit: .spades),
                     Card(rank: .two, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .eight, suit: .hearts), Card(rank: .eight, suit: .spades)],
                                 high: [Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .spades),
                                        Card(rank: .two, suit: .diamonds),
                                        Card(rank: .six, suit: .clubs),
                                        Card(rank: .six, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadA_K_Q_HandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .ace, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .ace, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .ace, suit: .clubs),
                     Card(rank: .ace, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .ace, suit: .hearts), Card(rank: .ace, suit: .spades)],
                                 high: [Card(rank: .ace, suit: .clubs),
                                        Card(rank: .ace, suit: .diamonds),
                                        Card(rank: .eight, suit: .hearts),
                                        Card(rank: .seven, suit: .spades),
                                        Card(rank: .six, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadJ_10_9_KickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .ace, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .ace, suit: .hearts), Card(rank: .seven, suit: .diamonds)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .spades),
                                        Card(rank: .eight, suit: .diamonds),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .six, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadJ_10_9_NoKickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .ten, suit: .hearts),
                     Card(rank: .ten, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .ten, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .ten, suit: .hearts), Card(rank: .ten, suit: .spades)],
                                 high: [Card(rank: .ten, suit: .diamonds),
                                        Card(rank: .ten, suit: .clubs),
                                        Card(rank: .seven, suit: .diamonds),
                                        Card(rank: .six, suit: .clubs),
                                        Card(rank: .two, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quad8_7_6_KickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .king, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .king, suit: .hearts), Card(rank: .seven, suit: .diamonds)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .spades),
                                        Card(rank: .eight, suit: .diamonds),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .six, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quad8_7_6_NoKickerHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .eight, suit: .hearts),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .eight, suit: .hearts), Card(rank: .eight, suit: .spades)],
                                 high: [Card(rank: .eight, suit: .diamonds),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .seven, suit: .diamonds),
                                        Card(rank: .six, suit: .clubs),
                                        Card(rank: .two, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quad5OrBelowHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .four, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .seven, suit: .diamonds), Card(rank: .six, suit: .clubs)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .spades),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .four, suit: .clubs),
                                        Card(rank: .two, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadPairHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .four, suit: .clubs),
                     Card(rank: .six, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .six, suit: .clubs), Card(rank: .six, suit: .diamonds)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .spades),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .four, suit: .clubs),
                                        Card(rank: .two, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadTripHandNoJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .six, suit: .hearts),
                     Card(rank: .four, suit: .hearts),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .six, suit: .clubs),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .four, suit: .clubs),
                     Card(rank: .six, suit: .diamonds)]
        
        let answerHand = PGPHand(low: [Card(rank: .six, suit: .hearts), Card(rank: .six, suit: .clubs)],
                                 high: [Card(rank: .four, suit: .hearts),
                                        Card(rank: .four, suit: .spades),
                                        Card(rank: .four, suit: .diamonds),
                                        Card(rank: .four, suit: .clubs),
                                        Card(rank: .six, suit: .diamonds)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func paiGowHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .six, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .eight, suit: .clubs)],
                                 high: [Card(rank: .joker, suit: .any),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .diamonds),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func onePairHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .queen, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .joker, suit: .any), Card(rank: .nine, suit: .hearts)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .queen, suit: .diamonds),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPairHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .queen, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .queen, suit: .diamonds)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .joker, suit: .any),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func threePairHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .queen, suit: .diamonds),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .queen, suit: .diamonds)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .joker, suit: .any),
                                        Card(rank: .three, suit: .spades),
                                        Card(rank: .three, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func tripsHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .two, suit: .hearts),
                     Card(rank: .seven, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .two, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .two, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .joker, suit: .any), Card(rank: .nine, suit: .hearts)],
                                 high: [Card(rank: .two, suit: .hearts),
                                        Card(rank: .two, suit: .diamonds),
                                        Card(rank: .two, suit: .clubs),
                                        Card(rank: .seven, suit: .hearts),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoTripsHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .queen, suit: .diamonds),
                     Card(rank: .queen, suit: .clubs),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .queen, suit: .diamonds)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .spades),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .joker, suit: .any),
                                        Card(rank: .queen, suit: .clubs)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func striaghtCompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .jack, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .joker, suit: .any), Card(rank: .three, suit: .spades)],
                                 high: [Card(rank: .seven, suit: .clubs),
                                        Card(rank: .eight, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .ten, suit: .diamonds),
                                        Card(rank: .jack, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func striaghtIncompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .three, suit: .spades)],
                                 high: [Card(rank: .seven, suit: .clubs),
                                        Card(rank: .eight, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .ten, suit: .diamonds),
                                        Card(rank: .joker, suit: .any)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushCompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .eight, suit: .clubs), Card(rank: .joker, suit: .any)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .three, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushIncompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .three, suit: .spades), Card(rank: .eight, suit: .clubs)],
                                 high: [Card(rank: .joker, suit: .any),
                                        Card(rank: .queen, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .hearts),
                                        Card(rank: .four, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func striaghtOnePairCompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .jack, suit: .hearts),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .seven, suit: .spades), Card(rank: .seven, suit: .clubs)],
                                 high: [Card(rank: .jack, suit: .hearts),
                                        Card(rank: .joker, suit: .any),
                                        Card(rank: .ten, suit: .diamonds),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .eight, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func striaghtOnePairIncompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .seven, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .ten, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .joker, suit: .any), Card(rank: .nine, suit: .hearts)],
                                 high: [Card(rank: .ten, suit: .diamonds),
                                        Card(rank: .ten, suit: .clubs),
                                        Card(rank: .eight, suit: .hearts),
                                        Card(rank: .seven, suit: .hearts),
                                        Card(rank: .three, suit: .spades)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushOnePairCompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .three, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .three, suit: .hearts), Card(rank: .three, suit: .clubs)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .joker, suit: .any),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .hearts),
                                        Card(rank: .four, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushOnePairIncompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .three, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .three, suit: .hearts), Card(rank: .three, suit: .spades)],
                                 high: [Card(rank: .queen, suit: .hearts),
                                        Card(rank: .joker, suit: .any),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .six, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func striaghtTripsCompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .seven, suit: .hearts),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .seven, suit: .spades), Card(rank: .seven, suit: .clubs)],
                                 high: [Card(rank: .seven, suit: .hearts),
                                        Card(rank: .eight, suit: .hearts),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .ten, suit: .diamonds),
                                        Card(rank: .joker, suit: .any)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func flushTripsCompleteHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .four, suit: .hearts),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .three, suit: .hearts),
                     Card(rank: .six, suit: .hearts),
                     Card(rank: .nine, suit: .hearts),
                     Card(rank: .three, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .three, suit: .spades), Card(rank: .three, suit: .clubs)],
                                 high: [Card(rank: .joker, suit: .any),
                                        Card(rank: .nine, suit: .hearts),
                                        Card(rank: .six, suit: .hearts),
                                        Card(rank: .four, suit: .hearts),
                                        Card(rank: .three, suit: .hearts)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func fullHouseHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .eight, suit: .spades),
                     Card(rank: .nine, suit: .diamonds),
                     Card(rank: .queen, suit: .clubs),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .queen, suit: .hearts), Card(rank: .queen, suit: .clubs)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .eight, suit: .spades),
                                        Card(rank: .eight, suit: .clubs),
                                        Card(rank: .joker, suit: .any),
                                        Card(rank: .nine, suit: .diamonds)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadAcesNoKickerHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .ace, suit: .hearts),
                     Card(rank: .ace, suit: .spades),
                     Card(rank: .nine, suit: .diamonds),
                     Card(rank: .ace, suit: .clubs),
                     Card(rank: .ace, suit: .diamonds),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .ace, suit: .hearts), Card(rank: .ace, suit: .spades)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .nine, suit: .diamonds),
                                        Card(rank: .ace, suit: .clubs),
                                        Card(rank: .ace, suit: .diamonds),
                                        Card(rank: .joker, suit: .any)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadAcesKickerHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .jack, suit: .hearts),
                     Card(rank: .ace, suit: .hearts),
                     Card(rank: .ace, suit: .spades),
                     Card(rank: .nine, suit: .diamonds),
                     Card(rank: .ace, suit: .clubs),
                     Card(rank: .ace, suit: .diamonds),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .jack, suit: .hearts), Card(rank: .joker, suit: .any)],
                                 high: [Card(rank: .ace, suit: .hearts),
                                        Card(rank: .ace, suit: .spades),
                                        Card(rank: .nine, suit: .diamonds),
                                        Card(rank: .ace, suit: .clubs),
                                        Card(rank: .ace, suit: .diamonds)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadNoAcesHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .seven, suit: .hearts),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .nine, suit: .diamonds),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .nine, suit: .diamonds), Card(rank: .joker, suit: .any)],
                                 high: [Card(rank: .eight, suit: .hearts),
                                        Card(rank: .seven, suit: .hearts),
                                        Card(rank: .seven, suit: .spades),
                                        Card(rank: .seven, suit: .clubs),
                                        Card(rank: .seven, suit: .diamonds)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func quadPairHandJoker() async throws {
        let board = PGPBoard()
        
        let cards = [Card(rank: .eight, suit: .hearts),
                     Card(rank: .seven, suit: .hearts),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .seven, suit: .clubs),
                     Card(rank: .seven, suit: .diamonds),
                     Card(rank: .joker, suit: .any)]
        
        let answerHand = PGPHand(low: [Card(rank: .eight, suit: .hearts), Card(rank: .eight, suit: .diamonds)],
                                 high: [Card(rank: .seven, suit: .hearts),
                                        Card(rank: .seven, suit: .spades),
                                        Card(rank: .seven, suit: .clubs),
                                        Card(rank: .seven, suit: .diamonds),
                                        Card(rank: .joker, suit: .any)])
        let testHand = board.getHandFromCards(cards: cards)
        #expect(testHand.low == answerHand.low)
        #expect(testHand.high == answerHand.high)
    }
    
    @Test mutating func twoPairNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .ten, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .queen, suit: .spades),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .ace, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .twoPair)
    }
    
    @Test mutating func tripsNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .ace, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .trips)
    }
    
    // TODO: Remaining tests
    
    @Test mutating func straightNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .nine, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .straight)
    }
    
    @Test mutating func straightJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .nine, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .straight)
    }
    
    @Test mutating func flusbNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .two, suit: .diamonds),
                     Card(rank: .ace, suit: .spades),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .nine, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .flush)
    }
    
    @Test mutating func flushJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .two, suit: .diamonds),
                     Card(rank: .four, suit: .spades),
                     Card(rank: .ace, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .nine, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .flush)
    }
    
    @Test mutating func fullHouseNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .jack, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .jack, suit: .hearts),
                     Card(rank: .eight, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .fullHouse)
    }
    
    @Test mutating func fullHouseJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .jack, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .fullHouse)
    }
    
    @Test mutating func quadsNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .eight, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .quads)
    }
    
    @Test mutating func quadsJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .eight, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .quads)
    }
    
    @Test mutating func straightFlushNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .spades),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .nine, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .straightFlush)
    }
    
    @Test mutating func straightFlushJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .spades),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .nine, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .straightFlush)
    }
    
    @Test mutating func royalFlushNoJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .ace, suit: .spades),
                     Card(rank: .ten, suit: .spades),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .seven, suit: .spades),
                     Card(rank: .queen, suit: .spades),
                     Card(rank: .king, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .royalFlush)
    }
    
    @Test mutating func royalFlushJokerBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .spades),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .queen, suit: .spades),
                     Card(rank: .ace, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .royalFlush)
    }
    
    @Test mutating func fiveOfAKindBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .eight, suit: .clubs),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .eight, suit: .diamonds),
                     Card(rank: .eight, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .fiveOfAKind)
    }
    
    @Test mutating func fiveAcesBonus() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .ace, suit: .spades),
                     Card(rank: .ten, suit: .diamonds),
                     Card(rank: .ace, suit: .clubs),
                     Card(rank: .ace, suit: .diamonds),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .queen, suit: .hearts),
                     Card(rank: .ace, suit: .hearts)]
        #expect(board.getBonusForCards(cards: cards) == .fiveAces)
    }
    
    @Test mutating func sevenCardStraightBonusNoJoker() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .eight, suit: .spades),
                     Card(rank: .nine, suit: .spades),
                     Card(rank: .ten, suit: .spades),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .queen, suit: .spades),
                     Card(rank: .king, suit: .spades),
                     Card(rank: .ace, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .sevenCardStraightFlush)
    }
    
    @Test mutating func sevenCardStraightBonusJoker() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .joker, suit: .any),
                     Card(rank: .nine, suit: .spades),
                     Card(rank: .ten, suit: .spades),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .queen, suit: .spades),
                     Card(rank: .king, suit: .spades),
                     Card(rank: .ace, suit: .spades)]
        #expect(board.getBonusForCards(cards: cards) == .sevenCardStraightFlush)
    }
    
    @Test mutating func highCardHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .four, suit: .clubs),
                     Card(rank: .jack, suit: .diamonds),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .ten, suit: .hearts),
                     Card(rank: .seven, suit: .hearts)]
        let ranking = HighHandRank(bonus: .highCard, cardRank: .jack, kickers: [Card(rank: .ten, suit: .hearts),
                                                                                Card(rank: .seven, suit: .hearts),
                                                                                Card(rank: .four, suit: .clubs),
                                                                                Card(rank: .three, suit: .spades)])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func pairHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .four, suit: .clubs),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .seven, suit: .hearts),
                     Card(rank: .two, suit: .hearts)]
        let ranking = HighHandRank(bonus: .pair, cardRank: .seven, kickers: [Card(rank: .four, suit: .clubs),
                                                                             Card(rank: .three, suit: .spades),
                                                                             Card(rank: .two, suit: .hearts)])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func twoPairHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .four, suit: .clubs),
                     Card(rank: .jack, suit: .diamonds),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .jack, suit: .hearts),
                     Card(rank: .four, suit: .hearts)]
        let ranking = HighHandRank(bonus: .twoPair, cardRank: .jack, kickers: [Card(rank: .four, suit: .clubs),
                                                                               Card(rank: .four, suit: .hearts),
                                                                               Card(rank: .three, suit: .spades)])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func tripsHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .four, suit: .clubs),
                     Card(rank: .jack, suit: .diamonds),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .four, suit: .hearts)]
        let ranking = HighHandRank(bonus: .trips, cardRank: .four, kickers: [Card(rank: .jack, suit: .diamonds),
                                                                             Card(rank: .three, suit: .spades)])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func straightHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .ace, suit: .hearts),
                     Card(rank: .five, suit: .spades),
                     Card(rank: .two, suit: .diamonds),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .three, suit: .clubs)]
        let ranking = HighHandRank(bonus: .straight, cardRank: .five, kickers: [])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func flushHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .ten, suit: .spades),
                     Card(rank: .five, suit: .spades),
                     Card(rank: .two, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .eight, suit: .spades)]
        let ranking = HighHandRank(bonus: .flush, cardRank: .ace, kickers: [Card(rank: .ten, suit: .spades),
                                                                            Card(rank: .eight, suit: .spades),
                                                                            Card(rank: .five, suit: .spades),
                                                                            Card(rank: .two, suit: .spades)])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func fullHouseHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .four, suit: .clubs),
                     Card(rank: .three, suit: .diamonds),
                     Card(rank: .three, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .four, suit: .hearts)]
        let ranking = HighHandRank(bonus: .fullHouse, cardRank: .four, kickers: [Card(rank: .three, suit: .diamonds), Card(rank: .three, suit: .spades)])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    
    @Test mutating func quadsHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .four, suit: .clubs),
                     Card(rank: .four, suit: .diamonds),
                     Card(rank: .two, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .four, suit: .hearts)]
        let ranking = HighHandRank(bonus: .quads, cardRank: .four, kickers: [Card(rank: .two, suit: .spades)])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func straightFlushHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .ace, suit: .spades),
                     Card(rank: .five, suit: .spades),
                     Card(rank: .two, suit: .spades),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .three, suit: .spades)]
        let ranking = HighHandRank(bonus: .straightFlush, cardRank: .five, kickers: [])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func royalFlushHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .ten, suit: .spades),
                     Card(rank: .queen, suit: .spades),
                     Card(rank: .ace, suit: .spades),
                     Card(rank: .jack, suit: .spades),
                     Card(rank: .joker, suit: .any)]
        let ranking = HighHandRank(bonus: .royalFlush, cardRank: .ace, kickers: [])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func fiveOfAKindHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .jack, suit: .spades),
                     Card(rank: .jack, suit: .hearts),
                     Card(rank: .jack, suit: .diamonds),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .jack, suit: .clubs)]
        let ranking = HighHandRank(bonus: .fiveOfAKind, cardRank: .jack, kickers: [])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func fiveAcesHighHand() async throws {
        let board = PGPBoard()
        let cards = [Card(rank: .ace, suit: .spades),
                     Card(rank: .ace, suit: .hearts),
                     Card(rank: .ace, suit: .diamonds),
                     Card(rank: .joker, suit: .any),
                     Card(rank: .ace, suit: .clubs)]
        let ranking = HighHandRank(bonus: .fiveAces, cardRank: .ace, kickers: [])
        
        #expect(board.getHighHandRank(cards: cards) == ranking)
    }
    
    @Test mutating func winHandComparison() async throws {
        let board = PGPBoard()
        let dealerCards = [Card(rank: .ace, suit: .clubs),
                           Card(rank: .three, suit: .hearts),
                          Card(rank: .ten, suit: .spades),
                           Card(rank: .four, suit: .clubs),
                           Card(rank: .nine, suit: .hearts),
                          Card(rank: .six, suit: .spades),
                           Card(rank: .eight, suit: .clubs)]
        
        let playerCards = [Card(rank: .eight, suit: .spades),
                          Card(rank: .eight, suit: .diamonds),
                          Card(rank: .ten, suit: .clubs),
                          Card(rank: .jack, suit: .spades),
                          Card(rank: .queen, suit: .spades),
                          Card(rank: .queen, suit: .hearts),
                          Card(rank: .ace, suit: .hearts)]
        
        let dealerHand = board.getHandFromCards(cards: dealerCards)
        let playerHand = board.getHandFromCards(cards: playerCards)
        
        let outcome = board.getHandComparison(dealerHand: dealerHand, playerHand: playerHand)
        
        #expect(outcome == .win)
    }
    
    @Test mutating func pushHandComparison() async throws {
        let board = PGPBoard()
        let dealerCards = [Card(rank: .eight, suit: .spades),
                          Card(rank: .nine, suit: .spades),
                          Card(rank: .ten, suit: .spades),
                          Card(rank: .jack, suit: .spades),
                          Card(rank: .queen, suit: .spades),
                          Card(rank: .king, suit: .spades),
                          Card(rank: .ace, suit: .spades)]
        
        let playerCards = [Card(rank: .eight, suit: .spades),
                          Card(rank: .eight, suit: .diamonds),
                          Card(rank: .ten, suit: .clubs),
                          Card(rank: .jack, suit: .spades),
                          Card(rank: .queen, suit: .spades),
                          Card(rank: .queen, suit: .hearts),
                          Card(rank: .ace, suit: .hearts)]
        
        let dealerHand = board.getHandFromCards(cards: dealerCards)
        let playerHand = board.getHandFromCards(cards: playerCards)
        
        let outcome = board.getHandComparison(dealerHand: dealerHand, playerHand: playerHand)
        
        #expect(outcome == .push)
    }
    
    @Test mutating func loseHandComparison() async throws {
        let board = PGPBoard()
        let dealerCards = [Card(rank: .ace, suit: .clubs),
                           Card(rank: .ace, suit: .hearts),
                          Card(rank: .ten, suit: .spades),
                          Card(rank: .jack, suit: .spades),
                          Card(rank: .queen, suit: .spades),
                          Card(rank: .king, suit: .spades),
                          Card(rank: .ace, suit: .spades)]
        
        let playerCards = [Card(rank: .ace, suit: .clubs),
                           Card(rank: .three, suit: .hearts),
                          Card(rank: .ten, suit: .spades),
                           Card(rank: .four, suit: .clubs),
                           Card(rank: .nine, suit: .hearts),
                          Card(rank: .six, suit: .spades),
                           Card(rank: .eight, suit: .clubs)]
        
        let dealerHand = board.getHandFromCards(cards: dealerCards)
        let playerHand = board.getHandFromCards(cards: playerCards)
        
        let outcome = board.getHandComparison(dealerHand: dealerHand, playerHand: playerHand)
        
        #expect(outcome == .lose)
    }
}
