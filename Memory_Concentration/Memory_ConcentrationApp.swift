//
//  Memory_ConcentrationApp.swift
//  Memory_Concentration
//
//  Created by on 2025/02/02.
//

import SwiftUI

@main
struct Memory_ConcentrationApp: App {
    var body: some Scene {
        WindowGroup {
            // 例：カード内容として絵文字（文字列）を使用
            let cardContents: [MemoryGame.CardContent] = [
                .text("🍎"), .text("🍊"), .text("🍇"), .text("🍓"), .text("🍒")
            ]
            // ペア数は、cardContents の数を超えないように設定（ここでは4ペア）
            ContentView(viewModel: MemoryGameViewModel(pairs: 4, cardContents: cardContents))
        }
    }
}
