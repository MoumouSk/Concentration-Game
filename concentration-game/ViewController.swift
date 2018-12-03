//
//  ViewController.swift
//  concentration-game
//
//  Created by Tom Hays on 24/09/2018.
//  Copyright © 2018 Tom Hays. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConcentrationGame(numberOfPairs: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private var themeArray = [Theme]()
    private var mainTheme: Theme?
    
    // Observers for dynamic labels values
    private(set) var flipCount = 0 {didSet {flipCountLabel.text = "Count: \(flipCount)"}}
    private(set) var  score = 0 {didSet {scoreLabel.text = "Score: \(score)"} }
    
    // What to do when lauching the view for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        initThemeArray()
        mainTheme = defineArrayByTheme()
        updateView()
    }

    // Launches new instance of game and reinit the view
    @IBAction private func launchNewGame(_ sender: UIButton) {
        flipCount = 0; score = 0
        game = ConcentrationGame(numberOfPairs: (cardButtons.count + 1 ) / 2)
        mainTheme = defineArrayByTheme()
        updateView()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    // What to do when pressing a card button in the view
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.selectCard(at: cardNumber)
            score = game.score
            flipCount = game.flipCount
            updateView()
        } else {
            print("A problem occured with the chosen card")
        }
    }
    
    // Refreshing the view depending on the operations processed
    private func updateView() {
        for index in cardButtons.indices {
            let card = game.cardStack[index]
            let button = cardButtons[index]
            button.backgroundColor = mainTheme?.cardBack
            view.backgroundColor = mainTheme?.backgroundColor
            if card.isFaced {
                button.setTitle(setEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : mainTheme?.cardBack
            }
        }
    }
    
    // Filling the themeArray
    private func initThemeArray() {
        themeArray.append(Theme(name: "animals", cardBack: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), emojisArray: ["🐵", "🐷", "🐨", "🦋", "🦊", "🐸", "🦁", "🦉", "🐮", "🐙"]))
        themeArray.append(Theme(name: "food", cardBack: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), emojisArray: ["🍕", "🍗", "🍩", "🍪", "🥗", "🍔", "🧀", "🍱", "🍫", "🥖"]))
        themeArray.append(Theme(name: "faces", cardBack: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), emojisArray: ["😎", "😇", "😤", "😡", "🤪", "😱", "🤢", "💩", "😴", "😍"]))
        themeArray.append(Theme(name: "halloween", cardBack: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), emojisArray: ["👻", "🕷", "👹", "☠️", "🎃", "👽", "🧛‍♂️", "🦇", "🔮", "💀"]))
    }
    
    // Randomly returning a theme from the array
    private func defineArrayByTheme() -> Theme {
        let randomTheme = Int(arc4random_uniform(UInt32(themeArray.count)))
        return themeArray[randomTheme]
    }


    private var emojiDico = [Card:String]()
   
    // Associates a card id with an emoji & removing used emojis from the array
    private func setEmoji(for card: Card) -> String {
        if (emojiDico[card]  == nil && !(mainTheme?.emojisArray.isEmpty)!) {
            emojiDico[card] = mainTheme!.emojisArray.remove(at: mainTheme!.emojisArray.count.arc4random)
        }
        return emojiDico[card] ?? "?"
    }
}

// Utility for Integer. Here, kind of a Macro for random int generation.
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32((self))))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32((abs(self)))))
        }
        else {
            return 0
        }
    }
}
