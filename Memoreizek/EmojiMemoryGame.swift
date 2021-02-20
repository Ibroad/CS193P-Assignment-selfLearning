//
//  EmojiMemoryGame.swift
//  Memoreizek
//
//  Created by Richard.ZHENG on 2021/1/26.
//

import Foundation
import UIKit

let themes = [
    Themes("Sports",#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),["🏀","🏈","⚽️","⚾️","🎾"]),
    Themes("Animals",#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),["🐭","🐻","🐶","🦊"]),
    Themes("Faces",#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), ["😁","😂","😍","😎","😒"]),
]


class EmojiMemoryGame:ObservableObject  {
    
  
   
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMyMemoryGame(theme: themes.randomElement()!)
    
    
    // MARK: Access to the Model
    var theme:Themes {
        model.theme
    }
    

    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    
    var score :Int{
        model.score
    }
    

    static func createMyMemoryGame(theme: Themes) -> MemoryGame<String> {
        
        
        let emojis = theme.contents
        
        
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 3...4),theme: theme){pairIndex in
            return emojis[pairIndex]
        }
    }
    
   
    
    
    
    // MARK: Intents
    func choose(card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card: card)
    }
    
    func newGame(){
        self.model = EmojiMemoryGame.createMyMemoryGame(theme: themes.randomElement()!)
    }
}
