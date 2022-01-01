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
    func addTurn(player: Int, asking: Int, suspectID: UUID?, weapondID: UUID?, roomID: UUID?, cardGave: CardType) throws {
        
        
    }
    
    /*
    func addTurn(player: Int, asking: Int, suspectID: UUID?, weapondID: UUID?, roomID: UUID?, cardGave: CardType) -> Bool {
        if(player == asking || player >= numberOfPlayers || player < 0 || asking >= numberOfPlayers || player < 0) {
            print("Invalid Player or Asking")
            return false
        }
        
        if let suspect = getSuspect(uuid: suspectID),
           let weapond = getWeapond(uuid: weapondID),
           let room = getRoom(uuid: roomID) {
            let newTurn = Turn(player: player, suspect: suspect, weapond: weapond, room: room, asking: asking, cardGave: cardGave)
            turns.append(newTurn)
            
            switch cardGave {
            case .Suspect:
                suspect.setHave(to: asking)
            case .Weapond:
                weapond.setHave(to: asking)
            case .Room:
                room.setHave(to: asking)
            case .None:
                suspect.addToDontHave(player: asking)
                weapond.addToDontHave(player: asking)
                room.addToDontHave(player: asking)
            case .Unknown:
                var counter: Int = 3
                
                if((suspect.isInocent && suspect.have != asking) || suspect.isGuilty) {
                    counter -= 1
                }
                if((weapond.isInocent && weapond.have != asking) || weapond.isGuilty) {
                    counter -= 1
                }
                if((room.isInocent && room.have != asking) || room.isGuilty) {
                    counter -= 1
                }
                
                if(counter <= 0) {//If Counter is 0, then someone cheated
                    print("I think someone cheated")
                } else if(counter == 1) { //If counter is 1, then we can deduce that `asking` the card that `asking` gave
                    if(!(suspect.isInocent || suspect.isGuilty)) {
                        suspect.setHave(to: asking)
                    }
                    if(!(weapond.isInocent || weapond.isGuilty)) {
                        weapond.setHave(to: asking)
                    }
                    if(!(room.isInocent || room.isGuilty)) {
                        room.setHave(to: asking)
                    }
                } else {//If counter is greater then 2, then we add that `asking` might have
                    if(!(suspect.isInocent || suspect.isGuilty)) {
                        suspect.addToMightHave(player: asking)
                    }
                    if(!(weapond.isInocent || weapond.isGuilty)) {
                        weapond.addToMightHave(player: asking)
                    }
                    if(!(room.isInocent || room.isGuilty)) {
                        room.addToMightHave(player: asking)
                    }
                }
            }
              
            checkSheet()
            return true
        }
        
        print("Invalid Item UUID")
        return false
    }
     */
    
}
