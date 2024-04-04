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
            CardView()
            CardView(isFaceUp: true)
            CardView()
            CardView(isFaceUp: true)
        }
        .foregroundColor(.accentColor)
        .padding()
    }
}

struct CardView: View{
    var isFaceUp: Bool = false
    var body: some View{
        ZStack{
            let base = Circle()
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text("🤯").font(.largeTitle)
            }else{
                base.fill()
            }
        }
    }
}

#Preview {
    ContentView()
}
