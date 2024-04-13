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
    
    @ViewBuilder
    private var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRation: cardAspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards){card in
                    CardView(card)
                        .aspectRatio(cardAspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
    
    private func gridItemWidthThatFits (
        count: Int,
        size: CGSize,
        atAspectRation aspectRatio: CGFloat) -> CGFloat
    {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
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
