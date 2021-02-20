//
//  MemoryGame.swift
//  Memoreizek
//
//  Created by Richard.ZHENG on 2021/1/26.
//
import UIKit
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: Array<Card>
    
    var indexOfTheOneAndTheOnlyFaceUpCard: Int? {
        get{ cards.indices.filter { cards[$0].isFaceUp}.only}
            
            
        set{
            for index in cards.indices {
        
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    
    var isFail = 0
    
    mutating func choose(card:Card)  {
        print("card chosen: \(card)")
        
        
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            cards[chosenIndex].isSeen += 1
            if let potentialMatchIndex = indexOfTheOneAndTheOnlyFaceUpCard {
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }else{
                    if cards[chosenIndex].isSeen>1 {
                        isFail -= 1
                    }
                    if cards[potentialMatchIndex].isSeen>1 {
                        isFail -= 1
                    }
                }
//                indexOfTheOneAndTheOnlyFaceUpCard = nil
                self.cards[chosenIndex].isFaceUp = true
            }else{
                
                // When there are 1 or 3 or 5...cards are faceup
//                for index in cards.indices {
//                    cards[index].isFaceUp = false
//                }
                indexOfTheOneAndTheOnlyFaceUpCard = chosenIndex
            }
             
           

        }
        print(isFail)
        
    }
    
    func countMatched(cards: Array<Card>) -> Int {
        var count = 0
        for index in cards.indices {
            if cards[index].isMatched {
                count+=1
            }
        }
        return count
    }
    
    
    
    
    var score: Int {
        return (countMatched(cards: cards)+isFail)
    }
    
    
    

    init(numberOfPairsOfCards: Int, theme: Themes, cardContentFactory: (Int) ->CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            
            let content = cardContentFactory(pairIndex)
            
            
            
            cards.append(Card(content: content,id: pairIndex*2))
            cards.append(Card(content: content,id: pairIndex*2+1))

        }
        cards = cards.shuffled()
        self.theme = theme
    }
    
    
    
    struct Card : Identifiable{
        var isFaceUp:Bool = false
        var isMatched:Bool = false
        var content: CardContent
        var isSeen: Int = 0
        
        var id : Int

        
    }
    
    var theme : Themes
    
    

}
struct Themes {
    let name : String
    
    let contents : Array<String>
    let color : UIColor
    
    init(_ name: String,_ color: UIColor, _ contents: Array<String>) {
        self.color = color
        self.contents = contents
        self.name = name
    }
    
}

