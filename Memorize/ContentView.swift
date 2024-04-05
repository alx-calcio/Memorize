//
//  ContentView.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount : Int = 4
    let emojis : [String] = ["😱", "😨", "😰", "😥", "😓", "😐", "🫤", "😑" ]
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false
            ){cards}
            Spacer()
            cardCountAdjusters
        }
        .foregroundColor(.accentColor)
        .padding()
    }
    var cardCountAdjusters: some View{
        HStack{
            cardRemover
            Spacer()
            Text("Memorize")
            Spacer()
            cardAdder
        }.font(.largeTitle)
    }
    func cardCountAdjusters(by offset: Int, symbol: String) -> some View{
        Button(action: {
                cardCount += offset}, label: {
                    Image(systemName: symbol)
                }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View{
        cardCountAdjusters(by: -1, symbol: "minus.circle.fill")
    }
    var cardAdder: some View{
        cardCountAdjusters(by: +1, symbol: "plus.circle.fill")
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 200))]) {
            ForEach(0 ..< cardCount, id: \.self){ index in
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
    ContentView()
}
