//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 06/04/2024.
//

import SwiftUI



class EmojiMemorizeGame: ObservableObject{
    typealias Card = MemorizeGame<String>.Card
    private static let emojis = ["😱", "😨", "😰", "😥", "😓", "😐", "🫤", "😑", "😬", "😳", "😢", "🤯"]
    
    private static func createMemorizeGame() -> MemorizeGame<String>{
     return MemorizeGame<String>(numberOfPairsOfCards: 2){pairIndex in
         if emojis.indices.contains(pairIndex){
        return emojis[pairIndex]
         } else {
             return "😬"
         }}}
    
    @Published private var model = createMemorizeGame()
    
    var cards: Array<Card>{
        model.cards
    }
    
    var color: Color {
        .accentColor
    }
    
    // MARK: - Intents
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: Card){
        model.choose(card)
    }
}
