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
        
        var probabilityGuilty: Float = 0.245
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
            
            probabilityGuilty = 0
            probabilityInocent = 1
        }
        
        mutating func setGuilty() {
            have = -1
            mightHave = [Int]()
            dontHave = [0, 1, 2, 3, 4, 5]
            
            probabilityGuilty = 1
            probabilityInocent = 0
        }
        
        mutating func setInocent() {
            if(!isInocent) {
                have = 6
                mightHave = [Int]()
                dontHave = [0, 1, 2, 3, 4, 5]
                
                probabilityGuilty = 0
                probabilityInocent = 1
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
            var firstElement: Bool = true
            
            for player in card.mightHave {
                if(player != user && player < numberOfPlayers) {
                    if(firstElement) {
                        firstElement = false
                    } else {
                        mightHave += ", "
                    }
                    
                    mightHave += playerNames[player]
                }
            }
        }
        
        return mightHave
    }
    
    func getCardDontHave(uuid: UUID?) -> String {
        var dontHave: String = ""
        
        if let card = getCard(uuid: uuid) {
            var firstElement: Bool = true
            
            for player in card.dontHave {
                if(player != user && player < numberOfPlayers) {
                    if(firstElement) {
                        firstElement = false
                    } else {
                        dontHave += ", "
                    }
                    
                    dontHave += playerNames[player]
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
        
        recalculateCards()
    }
    
    //MARK: - Adders
    /// - Throws: ``Game.CardError``
    func addInitialCards(ids: [UUID]) throws {
        for id in ids {
            try setCardHave(to: user, for: id)
        }
        
        recalculateCards()
    }
    
    /// - Throws: ``Game.CardError``
    func addCardMightHave(player: Int, for uuid: UUID?) throws {
        let cardIndex = getCardIndex(uuid: uuid)
        
        if(cardIndex >= 0 && cardIndex < cards.count) {
            cards[cardIndex].addToMightHave(player: player)
        } else {
            throw CardError.invalidUUID
        }
        
        recalculateCards()
    }
    
    /// - Throws: ``Game.CardError``
    func addCardDontHave(player: Int, for uuid: UUID?) throws {
        let cardIndex = getCardIndex(uuid: uuid)
        
        if(cardIndex >= 0 && cardIndex < cards.count) {
            cards[cardIndex].addToDontHave(player: player)
        } else {
            throw CardError.invalidUUID
        }
        
        recalculateCards()
    }
    
    //MARK: - Calculate
    func recalculateCards() {
        //Option 1: If There already exists 1 Guilty (card type) the rest must be inocent
        //Option 2: If there is 5 (total number of card type - 1) that are inoccent, then the remaianing card must be Guilty
        
        var numberOfSuspects: Int = 0
        var numberOfWeaponds: Int = 0
        var numberOfRooms: Int = 0
        
        var numberOfInocentSuspects: Int = 0
        var numberOfInocentWeaponds: Int = 0
        var numberOfInocentRooms: Int = 0
        
        var numberOfGuiltySuspects: Int = 0
        var numberOfGuiltyWeaponds: Int = 0
        var numberOfGuiltyRooms: Int = 0
        
        for card in cards {
            switch card.cardType {
            case .Suspect:
                numberOfSuspects += 1
                
                if(card.isInocent) {
                    numberOfInocentSuspects += 1
                }
                
                if(card.isGuilty) {
                    numberOfGuiltySuspects += 1
                }
            case .Weapond:
                numberOfWeaponds += 1
                
                if(card.isInocent) {
                    numberOfInocentWeaponds += 1
                }
                
                if(card.isGuilty) {
                    numberOfGuiltyWeaponds += 1
                }
            case .Room:
                numberOfRooms += 1
                
                if(card.isInocent) {
                    numberOfInocentRooms += 1
                }
                
                if(card.isGuilty) {
                    numberOfGuiltyRooms += 1
                }
            default:
                print("Error: Should never print")
            }
        }
        
        calculateCards(for: .Suspect, total: numberOfSuspects, inocent: numberOfInocentSuspects, guilty: numberOfGuiltySuspects)
        calculateCards(for: .Weapond, total: numberOfWeaponds, inocent: numberOfInocentWeaponds, guilty: numberOfGuiltyWeaponds)
        calculateCards(for: .Room, total: numberOfRooms, inocent: numberOfInocentRooms, guilty: numberOfGuiltyRooms)
    }
    
    func calculateCards(for type: CardType, total: Int, inocent: Int, guilty: Int) {
        if(guilty == 0) {
            if(inocent == total - 1) {
                for (index, card) in cards.enumerated() {
                    if(card.cardType == type && !card.isInocent) {
                        cards[index].setGuilty()
                    }
                }
            } else {
                calculateProbabilityGuilty(for: type, total: total, inocent: inocent, guilty: guilty)
            }
        } else if(guilty == 1) {
            for (index, card) in cards.enumerated() {
                if(card.cardType == type && !card.isGuilty) {
                    cards[index].setInocent()
                }
            }
        } else {
            print("Should not be possible as long as all the rules where followed")
        }
        
        calculateMaxProbabilityGuilty(for: type)
    }
    
    func calculateProbabilityGuilty(for type: CardType, total: Int, inocent: Int, guilty: Int) {
        for (index, card) in cards.enumerated() {
            if(card.cardType == type && !card.isInocent) {
                cards[index].probabilityGuilty = 1.0/Float(total - inocent)
            }
        }
    }
    
    func calculateMaxProbabilityGuilty(for type: CardType) {
        var maxProbability: Float = -1
        var maxUUID: UUID = UUID()
        
        for card in (type == .Suspect ? suspects : type == .Weapond ? weaponds : type == .Room ? rooms : [Card]()) {
            if(card.isGuilty) {
                maxUUID = card.id
                break
            }
            
            if(card.probabilityGuilty > maxProbability) {
                maxProbability = card.probabilityGuilty
                maxUUID = card.id
            }
        }
        
        if(type == .Suspect) {
            mostGuiltySuspect = maxUUID
        } else if(type == .Weapond) {
            mostGuiltyWeapond = maxUUID
        } else if(type == .Room) {
            mostGuiltyRoom = maxUUID
        } else {
            print("ERROR: Should never print")
        }
    }
}
