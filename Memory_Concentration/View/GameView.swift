//
//  GameView.swift
//  Memory_Concentration
//
//  Created by on 2025/02/02.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: MemoryGameViewModel
    @State private var showingPhotoPicker = false
    @State private var selectedImages: [UIImage] = []
    
    // カード表示のグリッドレイアウト設定（カードサイズに応じて調整）
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        VStack {
            HStack {
                Text("Current Turn: \(viewModel.currentPlayerName)")
                    .font(.headline)
                Spacer()
                Button(action: {
                    showingPhotoPicker = true
                }) {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title)
                }
            }
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
        .sheet(isPresented: $showingPhotoPicker) {
            // 写真ピッカーが閉じられたときに、選択された画像を元にゲームを再スタート
            if !selectedImages.isEmpty {
                let cardContents: [MemoryGame.CardContent] = selectedImages.map { image in
                        .uiImage(image, identifier: UUID().uuidString)
                }
                viewModel.restartGame(pairs: cardContents.count, cardContents: cardContents)
                selectedImages.removeAll()
            }
        } content: {
            PhotoPickerView(selectedImages: $selectedImages)
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
        case .uiImage(let image, identifier: _):
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
}

//#Preview {
//    ContentView()
//}
