//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 06/04/2024.
//

import SwiftUI



class EmojiMemorizeGame: ObservableObject{
    private static let emojis = ["😱", "😨", "😰", "😥", "😓", "😐", "🫤", "😑", "😬", "😳", "😢", "🤯"]
    
    private static func createMemorizeGame() -> MemorizeGame<String>{
     return MemorizeGame<String>(numberOfPairsOfCards: 10){pairIndex in
         if emojis.indices.contains(pairIndex){
        return emojis[pairIndex]
         } else {
             return "😬"
         }}}
    
    @Published private var model = createMemorizeGame()
    
    var cards: Array<MemorizeGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGame<String>.Card){
        model.choose(card)
    }
}
