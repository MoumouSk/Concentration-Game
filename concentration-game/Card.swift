//
//  Card.swift
//  concentration-game
//
//  Created by Tom Hays on 24/09/2018.
//  Copyright © 2018 Tom Hays. All rights reserved.
//

import Foundation

struct Card
{
    var id: Int
    var isFaced = false
    var isMatched = false
    var alreadySeen = false

    static var idFactory = 0
    static var flipCount = 0
    
    static func getUniqueId() -> Int {
        Card.idFactory += 1
        return Card.idFactory
    }
    
    func IncrementAndTrackFlipCount() -> Int {
        Card.flipCount += 1
        return Card.flipCount
    }
    
    init() {
        self.id = Card.getUniqueId();
    }
}
