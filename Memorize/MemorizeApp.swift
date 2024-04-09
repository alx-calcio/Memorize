//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alexandre Calcio Gaudino on 01/04/2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemorizeGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemorizeGameView(viewModel: game)
        }
    }
}
