//
//  Theme.swift
//  concentration-game
//
//  Created by Tom Hays on 25/09/2018.
//  Copyright © 2018 Tom Hays. All rights reserved.
//

import UIKit

// This is a structure for the themes. Here we have all the necessaries info related to the themes.
// This struct will be filled in an array of Themes. Has to be initialized with required values.

struct Theme
{
    var name: String
    var cardBack: UIColor
    var backgroundColor: UIColor
    var emojisArray: [String]
    
    init(name: String, cardBack: UIColor, backgroundColor: UIColor, emojisArray: [String]) {
        self.name = name
        self.cardBack = cardBack
        self.backgroundColor = backgroundColor
        self.emojisArray = emojisArray
    }
}
