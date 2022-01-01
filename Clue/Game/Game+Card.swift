//
//  Card.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import Foundation

extension Game {
    struct Card : Identifiable {
        let id: UUID = UUID()
        let name: String
        let imageName: String
        let cardType: CardType
        
        var probabilityGuilty: Float = 0
        var probabilityInocent: Float = 0
        
        var have: Int = -1
        var mightHave: [Int] = [Int]()
        var dontHave: [Int] = [Int]()
        
        var isGuilty: Bool {
            return dontHave.count == 6

        }
        
        var isInocent: Bool {
            return (have >= 0)
        }
        
        mutating func addToDontHave(player: Int) {
            if(have < 0 && !dontHave.contains(player)) {
                dontHave.append(player)
            }
        }
        
        mutating func addToMightHave(player: Int) {
            if(have < 0 && !mightHave.contains(player)) {
                mightHave.append(player)
            }
        }
        
        mutating func setHave(to player: Int) {
            have = player
            mightHave = [Int]()
            dontHave = [0, 1, 2, 3, 4, 5]
            dontHave.removeAll { i in
                return i == player
            }
        }
    }

    //MARK: - Getters
    func getCard(uuid: UUID?) -> Card? {
        for card in cards {
            if(card.id == uuid) {
                return card
            }
        }
        
        return nil
    }
    
    func getCardIndex(uuid: UUID?) -> Int {
        for i in 0..<cards.count {
            if(cards[i].id == uuid) {
                return i
            }
        }
        
        return -1
    }
    
    func getCardName(uuid: UUID?) -> String {
        if let card = getCard(uuid: uuid) {
            return card.name
        }
        return ""
    }
    
    func getCardImageName(uuid: UUID?) -> String {
        if let card = getCard(uuid: uuid) {
            return card.imageName
        }
        return ""
    }
    
    func getCardMightHave(uuid: UUID?) -> String {
        var mightHave: String = ""
        
        if let card = getCard(uuid: uuid) {
            for i in 0..<card.mightHave.count {
                mightHave += playerNames[card.mightHave[i]]
                
                if(i != card.mightHave.count - 1) {
                    mightHave += ", "
                }
            }
        }
        
        return mightHave
    }
    
    func getCardDontHave(uuid: UUID?) -> String {
        var dontHave: String = ""
        
        if let card = getCard(uuid: uuid) {
            for i in 0..<card.dontHave.count {
                dontHave += playerNames[card.dontHave[i]]
                
                if(i != card.dontHave.count - 1) {
                    dontHave += ", "
                }
            }
        }
        
        return dontHave
    }
    
    //MARK: - Setters
    func setCardHave(to player: Int, for uuid: UUID?) throws {
        let cardIndex = getCardIndex(uuid: uuid)
        
        if(cardIndex >= 0 && cardIndex < cards.count) {
            cards[cardIndex].setHave(to: player)
        } else {
            throw CardError.invalidUUID
        }
    }
    
    //MARK: - Adders
    func addInitialCards(ids: [UUID]) throws {
        for id in ids {
            try setCardHave(to: user, for: id)
        }
    }
    
    func addCardMightHave(player: Int, for uuid: UUID?) throws {
        let cardIndex = getCardIndex(uuid: uuid)
        
        if(cardIndex >= 0 && cardIndex < cards.count) {
            cards[cardIndex].addToMightHave(player: player)
        } else {
            throw CardError.invalidUUID
        }
    }
    
    func addCardDontHave(player: Int, for uuid: UUID?) throws {
        let cardIndex = getCardIndex(uuid: uuid)
        
        if(cardIndex >= 0 && cardIndex < cards.count) {
            cards[cardIndex].addToDontHave(player: player)
        } else {
            throw CardError.invalidUUID
        }
    }
}
