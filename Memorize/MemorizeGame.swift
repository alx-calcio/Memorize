//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 06/04/2024.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    private var indexOfFirstAndOnlyFacedUpCard: Int? {
        get { return cards.indices.filter {index in cards[index].isFaceUp}.only }
        set { return cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)}} }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentialMatchIndex = indexOfFirstAndOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfFirstAndOnlyFacedUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        var id: String
        var debugDescription: String {
             "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" :"")"
        }
    }
}

extension Array{
    var only: Element? {
        return count == 1 ? first : nil
    }
}
