//
//  ViewController.swift
//  concentration-game
//
//  Created by Tom Hays on 24/09/2018.
//  Copyright © 2018 Tom Hays. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcentrationGame(numberOfPairs: (cardButtons.count + 1 ) / 2)
    private var themeArray = [Theme]()
    private var mainTheme: Theme?
    
    var flipCount = 0 {didSet {flipCountLabel.text = "Count: \(flipCount)"}}
    var score = 0 {didSet {scoreLabel.text = "Score: \(score)"} }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initThemeArray()
        mainTheme = defineArrayByTheme()
        updateView()
    }
    
    @IBAction func launchNewGame(_ sender: UIButton) {
        flipCount = 0; score = 0
        game = ConcentrationGame(numberOfPairs: (cardButtons.count + 1 ) / 2)
        mainTheme = defineArrayByTheme()
        updateView()
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.selectCard(at: cardNumber)
            score = game.score
            flipCount = game.flipCount
            updateView()
        } else {
            print("A problem occured with the chosen card")
        }
    }
    
    func updateView() {
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
    
    func initThemeArray() {
        themeArray.append(Theme(name: "animals", cardBack: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), backgroundColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), emojisArray: ["🐵", "🐷", "🐨", "🦋", "🦊", "🐸", "🦁", "🦉", "🐮", "🐙"]))
        themeArray.append(Theme(name: "food", cardBack: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), emojisArray: ["🍕", "🍗", "🍩", "🍪", "🥗", "🍔", "🧀", "🍱", "🍫", "🥖"]))
        themeArray.append(Theme(name: "faces", cardBack: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), emojisArray: ["😎", "😇", "😤", "😡", "🤪", "😱", "🤢", "💩", "😴", "😍"]))
        themeArray.append(Theme(name: "halloween", cardBack: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), emojisArray: ["👻", "🕷", "👹", "☠️", "🎃", "👽", "🧛‍♂️", "🦇", "🔮", "💀", "🤡"]))
    }
    
    func defineArrayByTheme() -> Theme {
        let randomTheme = Int(arc4random_uniform(UInt32(themeArray.count)))
        return themeArray[randomTheme]
    }


    var emojiDico = [Int:String]()
    
    func setEmoji(for card: Card) -> String {
        if (emojiDico[card.id] == nil && !(mainTheme?.emojisArray.isEmpty)!) {
            let random = Int(arc4random_uniform(UInt32((mainTheme?.emojisArray.count)! - 1)))
            emojiDico[card.id] = mainTheme?.emojisArray.remove(at: random)
        }
        return emojiDico[card.id] ?? "?"
    }
}

