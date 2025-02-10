//
//  GameView.swift
//  Memory_Concentration
//
//  Created by on 2025/02/02.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: MemoryGameViewModel
    
    // カード表示のグリッドレイアウト設定（カードサイズに応じて調整）
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        VStack {
            Text("Current Turn: \(viewModel.currentPlayerName)")
                .font(.headline)
                .padding()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding()
        }
    }
}

struct CardView: View {
    let card: MemoryGame.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                cardContent(for: card.content)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    // カードコンテンツの表示（enum の値によって文字列または画像を切り替え）
    @ViewBuilder
    func cardContent(for content: MemoryGame.CardContent) -> some View {
        switch content {
        case .text(let text):
            Text(text)
                .font(.largeTitle)
        case .image(let imageName):
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
    }
}

//#Preview {
//    ContentView()
//}
