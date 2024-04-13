//
//  CardView.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 13/04/2024.
//

import SwiftUI



struct CardView: View{
    typealias Card = MemorizeGame<String>.Card
    
    private let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Circle()
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                        .font(.system(size: Constants.FontSize.largest))
                        .minimumScaleFactor(Constants.FontSize.scaleFactor)
                        .multilineTextAlignment(.center)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(Constants.Pie.inset)
                    )
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0 )
            base.fill().opacity(card.isFaceUp ? 0 : 1 )
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
    
}

#Preview {
    typealias Card = CardView.Card
    return VStack{
        HStack{
            CardView(Card(isFaceUp: true, content: "x", id: "test1"))
            CardView(Card(content: "x", id: "test1"))
        }
        HStack{
            CardView(Card(isFaceUp: true, content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", id: "test1"))
            CardView(Card(isMatched: true, content: "x", id: "test1"))
        }
    }
    .padding()
    .foregroundColor(.blue)}
