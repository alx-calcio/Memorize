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
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false
            ){
                cards.animation(.default, value: viewModel.cards)
            }
                .foregroundColor(.accentColor)
                .padding()
            Button(action: {viewModel.shuffle()}){
                Image(systemName: "shuffle.circle.fill").font(.largeTitle)
            }
        }
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards){card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
}

struct CardView: View{
    let card: MemorizeGame<String>.Card
    
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
