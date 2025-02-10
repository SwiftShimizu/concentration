//
//  MemoryGameViewModel.swift
//  Memory_Concentration
//
//  Created by on 2025/02/02.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame
    @Published var currentPlayer: Int = 0
    var players: [String] = ["Player1", "Player2"]
    
    var currentPlayerName: String {
        players[currentPlayer]
    }
    
    // ゲーム内のカード一覧
    var cards: [MemoryGame.Card] {
        model.cards
    }
    
    // 初期化（指定したペア数とカード内容の配列でゲーム開始）
    init(pairs: Int, cardContents: [MemoryGame.CardContent]) {
        let numberOfPairs = min(cardContents.count, pairs)
        model = MemoryGame(numberOfPairs: numberOfPairs, cardContents: cardContents)
    }
    
    // カード選択時の処理
    func choose(_ card: MemoryGame.Card) {
        let matchFound = model.choose(card)
        objectWillChange.send()
        if !matchFound {
            // マッチしなかった場合、1秒後にカードを裏返し、ターンを交代する
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.model.flipDownNonMatchedCards()
                self.objectWillChange.send()
                self.currentPlayer = (self.currentPlayer + 1) % self.players.count
            }
        }
    }
    
    // ゲームの再スタート
    func restartGame(pairs: Int, cardContents: [MemoryGame.CardContent]) {
        let numberOfPairs = min(pairs, cardContents.count)
        model = MemoryGame(numberOfPairs: numberOfPairs, cardContents: cardContents)
        currentPlayer = 0
        objectWillChange.send()
    }
    
}
