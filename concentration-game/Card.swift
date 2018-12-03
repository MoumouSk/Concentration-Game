//
//  Card.swift
//  concentration-game
//
//  Created by Tom Hays on 24/09/2018.
//  Copyright © 2018 Tom Hays. All rights reserved.
//

import Foundation

// This struct represents one Card and all the info that it needs. Will be used by the Game instance
// and nearly everywhere throughout the code.

struct Card: Hashable
{
    var hashValue: Int { return id }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    private var id: Int
    var isFaced = false
    var isMatched = false
    var alreadySeen = false

    
    // Those set & return an unique id for each card
    static var idFactory = 0
    static func getUniqueId() -> Int {
        Card.idFactory += 1
        return Card.idFactory
    }
    
    // Each time a card is initalized, we give it an unique id by calling the static factory again
    init() {
        self.id = Card.getUniqueId();
    }
}
