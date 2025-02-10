//
//  MemoryGame.swift
//  Memory_Concentration
//
//  Created by on 2025/02/02.
//

import Foundation

struct MemoryGame {
    
    // カードの定義
    struct Card: Identifiable {
        var id: Int
        var content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }
    
    // カードの内容：文字列または画像名（Assets に登録した画像）
    enum CardContent: Equatable {
        case text(String)
        case image(String)
    }
    
    // ゲーム内のカード配列
    private(set) var cards: [Card]
    // １枚だけ表向きのカードのインデックスを記録
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    // カードを選択したときの処理（２枚目の場合は一致判定）
    mutating func choose(_ card: Card) -> Bool {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                // ２枚目のカードを選んだ場合
                cards[chosenIndex].isFaceUp = true
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // マッチした場合は両方マッチ済みにする
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    indexOfOneAndOnlyFaceUpCard = nil
                    return true
                } else {
                    // マッチしなかった場合は、裏返す処理は後でタイマーで行う
                    return false
                }
            } else {
                // 既に 2 枚以上表向きになっている場合、または初回選択の場合はすべて裏返してから
                for index in cards.indices {
                    if !cards[index].isMatched {
                        cards[index].isFaceUp = false
                    }
                }
                cards[chosenIndex].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        return true
    }
    
    // マッチしていないカードをすべて裏返す処理（ターン終了時に呼び出し）
    mutating func flipDownNonMatchedCards() {
        for index in cards.indices {
            if !cards[index].isMatched {
                cards[index].isFaceUp = false
            }
        }
        indexOfOneAndOnlyFaceUpCard = nil
    }
    
    // 初期化：指定したペア数とカードコンテンツ配列をもとにカードを作成（ペア数はコンテンツ数を超えない）
    init(numberOfPairs: Int, cardContents: [CardContent]) {
        cards = []
        let number = min(numberOfPairs, cardContents.count)
        for pairIndex in 0..<number {
            let content = cardContents[pairIndex]
            let card1 = Card(id: pairIndex * 2, content: content)
            let card2 = Card(id: pairIndex * 2 + 1, content: content)
            cards += [card1, card2]
        }
        cards.shuffle()
    }
    
}
