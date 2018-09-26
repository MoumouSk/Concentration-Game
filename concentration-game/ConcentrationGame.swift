//
//  ConcentrationGame.swift
//  concentration-game
//
//  Created by Tom Hays on 24/09/2018.
//  Copyright © 2018 Tom Hays. All rights reserved.
//

import Foundation

class ConcentrationGame
{
    var cardStack = [Card]()
    var facedUpCard: Int?
    var score = 0
    var flipCount = 0

    func selectCard (at index: Int) {
        if !cardStack[index].isMatched {
            if let match = facedUpCard, match != index {
                if cardStack[match].id == cardStack[index].id {
                    score += 2
                    cardStack[match].isMatched = true
                    cardStack[index].isMatched = true
                }
                else {
                    if (cardStack[index].alreadySeen) {score -= 1}
                    if (cardStack[match].alreadySeen) {score -= 1}
                    cardStack[index].alreadySeen = true
                    cardStack[match].alreadySeen = true
                }
                    cardStack[index].isFaced = true
                    facedUpCard = nil
            }
            else {
                for flipDown in cardStack.indices {
                    cardStack[flipDown].isFaced = false
                }
                cardStack[index].isFaced = true
                facedUpCard = index
            }
            flipCount += 1
        }
    }
    
    init(numberOfPairs: Int) {
        for _ in 1...numberOfPairs {
            let card = Card()
            cardStack += [card, card]
        }
        cardStack.shuffle()
    }
}
