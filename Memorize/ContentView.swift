//
//  ContentView.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            let emojis : [String] = ["😱", "😨", "😰", "😥"]
            ForEach(emojis.indices, id: \.self){ index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.accentColor)
        .padding()
    }
}

struct CardView: View{
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View{
        ZStack{
            let base = Circle()
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)
            }else{
                base.fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
