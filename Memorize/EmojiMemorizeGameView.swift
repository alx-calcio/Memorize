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
    private let spacing: CGFloat = 4
    var body: some View {
        VStack {
            cards
                .animation(Animation.smooth, value: viewModel.cards)
                .foregroundColor(viewModel.color)
            Button(action: {viewModel.shuffle()}){
                Image(systemName: "shuffle.circle.fill").font(.largeTitle)
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, cardAspectRatio: cardAspectRatio){ card in
            CardView(card)
                .padding(spacing)
                .onTapGesture { viewModel.choose(card) }
        }
    }
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
