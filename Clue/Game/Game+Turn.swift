//
//  Turn.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import Foundation

extension Game {
    struct Turn: Identifiable {
        let id = UUID()
        let player: Int
        let suspect: Card
        let weapond: Card
        let room: Card
        
        let asking: Int
        let cardGave: Game.CardType
        
        func cardGaveToString() -> String {
            switch cardGave {
            case .Suspect:
                return suspect.name
            case .Weapond:
                return weapond.name
            case .Room:
                return room.name
            case .Unknown:
                return "Unknown"
            case .None:
                return "None"
            }
        }
    }
    
    //MARK: - Getters
    func getTurn(uuid: UUID) -> Turn? {
        for turn in turns {
            if(turn.id == uuid) {
                return turn
            }
        }
        
        return nil
    }
    
    func getTurnNumber(uuid: UUID) -> Int {
        for i in 0..<turns.count {
            if(turns[i].id == uuid) {
                return i+1
            }
        }
        
        return -1
    }
    
    //MARK: - Setters
    
    //MARK: - Adders
    /// - Throws: ``Game.TurnError``, ``Game.CardError``, and ``Game.GameError``
    func addTurn(player: Int, asking: Int, suspectID: UUID?, weapondID: UUID?, roomID: UUID?, cardGave: CardType) throws {
        //Check Paremters
        if(player == asking) {
            throw TurnError.playerAskingEqual
        }
        
        if(player < 0 || player >= numberOfPlayers) {
            throw TurnError.invalidPlayer
        }
        
        if(asking < 0 || asking >= numberOfPlayers) {
            throw TurnError.invalidAsking
        }
        
        if(player == user && cardGave == .Unknown) {
            throw TurnError.userKnownsCard
        }
        
        guard let suspect = getCard(uuid: suspectID) else {
            throw TurnError.invalidSuspect
        }
        
        if(suspect.cardType != .Suspect) {
            throw TurnError.invalidSuspect
        }
        
        guard let weapond = getCard(uuid: weapondID) else {
            throw TurnError.invalidWeapond
        }
        
        if(weapond.cardType != .Weapond) {
            throw TurnError.invalidWeapond
        }
        
        guard let room = getCard(uuid: roomID) else {
            throw TurnError.invalidRoom
        }
        
        if(room.cardType != .Room) {
            throw TurnError.invalidRoom
        }
        
        //Turn Logic
        switch cardGave {
        case .Suspect:
            try setCardHave(to: asking, for: suspectID)
        case .Weapond:
            try setCardHave(to: asking, for: weapondID)
        case .Room:
            try setCardHave(to: asking, for: roomID)
        case .None:
            try addCardDontHave(player: asking, for: suspectID)
            try addCardDontHave(player: asking, for: weapondID)
            try addCardDontHave(player: asking, for: roomID)
        case .Unknown: //Gave card but not sure which one
            //Cards asked that we someone else (not asking) has or we know is guility
            var knownCards: Int = 0
            
            if((suspect.isInocent && suspect.have != asking) || suspect.isGuilty) {
                knownCards += 1
            }
            if((weapond.isInocent && weapond.have != asking) || weapond.isGuilty) {
                knownCards += 1
            }
            if((room.isInocent && room.have != asking) || room.isGuilty) {
                knownCards += 1
            }
            
            if(knownCards == 3) {
                //If they gave the card even though we already know that (based on previous turns) that they should not have have one. The most likly outcome is someone cheated (someone gave no cards but they actully had one)
                
                //We are still going to add turn, but we want to notify user that someone cheated so we are going to throw an error as well
                //Add Turn
                let newTurn = Turn(player: player, suspect: suspect, weapond: weapond, room: room, asking: asking, cardGave: cardGave)
                turns.append(newTurn)
                throw GameError.someoneCheated
            } else if(knownCards == 2) {
                //If know that 2/3 cards belong to someone else / are guilty, we can conclude that the remaing card must be the card that asking gave.
                if(!(suspect.isInocent || suspect.isGuilty)) {
                    try setCardHave(to: asking, for: suspectID)
                }
                if(!(weapond.isInocent || weapond.isGuilty)) {
                    try setCardHave(to: asking, for: weapondID)
                }
                if(!(room.isInocent || room.isGuilty)) {
                    try setCardHave(to: asking, for: roomID)
                }
            } else {
                //If we only know 1/3 of the cards or none at all then we cannot conclude anythign
                if(!(suspect.isInocent || suspect.isGuilty)) {
                    try addCardMightHave(player: asking, for: suspectID)
                }
                if(!(weapond.isInocent || weapond.isGuilty)) {
                    try addCardMightHave(player: asking, for: weapondID)
                }
                if(!(room.isInocent || room.isGuilty)) {
                    try addCardMightHave(player: asking, for: roomID)
                }
            }
        }
        
        //Add Turn
        let newTurn = Turn(player: player, suspect: suspect, weapond: weapond, room: room, asking: asking, cardGave: cardGave)
        turns.append(newTurn)
        recalculateCards()
    }
    
}
