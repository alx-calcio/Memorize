//
//  ContentView.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 01/04/2024.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    let emojis : [String] = ["😱", "😨", "😰", "😥", "😓", "😐", "🫤", "😑"]
    private let cardAspectRatio: CGFloat = 2/3
    var body: some View {
        VStack{
            cards.animation(Animation.smooth, value: viewModel.cards)
            .foregroundColor(Color.accentColor)
                .padding()
            Button(action: {viewModel.shuffle()}){
                Image(systemName: "shuffle.circle.fill").font(.largeTitle)
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, cardAspectRatio: cardAspectRatio){ card in
            CardView(card)
                .padding(4)
                .onTapGesture { viewModel.choose(card) }
        }
    }
}

struct CardView: View{
    private let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 20)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)}
            .opacity(card.isFaceUp ? 1 : 0 )
            base.fill().opacity(card.isFaceUp ? 0 : 1 )
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
