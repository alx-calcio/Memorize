//
//  ContentView.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 01/04/2024.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    var viewModel: EmojiMemorizeGame
    let emojis : [String] = ["😱", "😨", "😰", "😥", "😓", "😐", "🫤", "😑"]
    var body: some View {
            ScrollView(showsIndicators: false
            ){cards}
        .foregroundColor(.accentColor)
        .padding()
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 200))]) {
            ForEach(emojis.indices, id: \.self){index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
}

struct CardView: View{
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 20)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)}
            .opacity(isFaceUp ? 1 : 0 )
            base.fill().opacity(isFaceUp ? 0 :1 )
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    EmojiMemorizeGameView()
}
