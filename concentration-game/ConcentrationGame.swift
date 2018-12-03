//
//  ConcentrationGame.swift
//  concentration-game
//
//  Created by Tom Hays on 24/09/2018.
//  Copyright © 2018 Tom Hays. All rights reserved.
//

import Foundation

// This is the class that manages the game rules & behaviour. 

class ConcentrationGame
{
    private(set) var cardStack = [Card]()
    private var facedUpCard: Int? {
        get {
            return cardStack.indices.filter { cardStack[$0].isFaced }.oneAndOnly
        }
        set(newValue) {
            for index in cardStack.indices {
                cardStack[index].isFaced = (index == newValue)
            }
        }
    }
    private(set) var score = 0
    private(set) var flipCount = 0
    private var timeBegin: Date?
    private var elapsedTime: Double {
        get {
            return Date().timeIntervalSince(timeBegin!)
        }
    }
 
    // Main algorithm of the game: Cards behaviour, score, flips counting, time
    func selectCard (at index: Int) {
        assert(cardStack.indices.contains(index), "ConcentrationGame.selectCard(at: \(index)): chosen index is not in the card stack")
        if !cardStack[index].isMatched {
            if let match = facedUpCard, match != index { //Si facedUp != nil -> une carte est levée, cette card est match
                if cardStack[match] == cardStack[index] {
                    score += elapsedTime.timeToInt
                    cardStack[match].isMatched = true
                    cardStack[index].isMatched = true
                }
                else {
                    if (cardStack[index].alreadySeen) {score += 3}
                    if (cardStack[match].alreadySeen) {score += 3}
                    cardStack[index].alreadySeen = true
                    cardStack[match].alreadySeen = true
                }
                cardStack[index].isFaced = true
            }
            else { //Aucune ou deux cartes retournées
                facedUpCard = index
                timeBegin = Date()
            }
            flipCount += 1
        }
    }
    
    // Game initialization, specifying the number of pairs we have
    init(numberOfPairs: Int) {
        assert(numberOfPairs > 0, "ConcentrationGame.init(\(numberOfPairs)): numbers of pairs must be greater than   0")
        for _ in 1...numberOfPairs {
            let card = Card()
            cardStack += [card, card]
        }
        cardStack.shuffle()
    }
}


// Return 1 if there is only 1 Element in the Collection, else return nil
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

// Convert a Double to an Int, and round it to the closest value - always to 1 if it's 0...1
extension Double {
    var timeToInt: Int {
        if (self < 1) {
            return Int(ceil(self))
        }
        return Int(self.rounded())
    }
}
