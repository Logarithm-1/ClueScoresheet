//
//  Game.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import Foundation

struct Game {
    var suspects: [Card] = [Card(name: "Colonel Mustard", imageName: "colonelMusard"),
                            Card(name: "Professor Plum", imageName: "professorPlum"),
                            Card(name: "Mr. Green", imageName: "mrGreen"),
                            Card(name: "Mrs. Peacock", imageName: "mrsPeacock"),
                            Card(name: "Miss scarlet", imageName: "missScarlet"),
                            Card(name: "Mrs. White", imageName: "mrsWhite")]
    var weaponds: [Card] = [Card(name: "Knife", imageName: "knife"),
                            Card(name: "Candle Stick", imageName: "candleStick"),
                            Card(name: "Revolver", imageName: "revolver"),
                            Card(name: "Rope", imageName: "rope"),
                            Card(name: "Lead Pipe", imageName: "leadPipe"),
                            Card(name: "Wrench", imageName: "wrench")]
    var rooms: [Card]    = [Card(name: "Hall", imageName: "hall"),
                            Card(name: "Lounge", imageName: "lounge"),
                            Card(name: "Dinning Room", imageName: "dinning"),
                            Card(name: "Kitchen", imageName: "kitchen"),
                            Card(name: "Ball Room", imageName: "ball"),
                            Card(name: "Conservatorty", imageName: "conservatory"),
                            Card(name: "Billiard Room", imageName: "billiard"),
                            Card(name: "Library", imageName: "library"),
                            Card(name: "Study", imageName: "study")]
    var turns: [Turn] = [Turn]()
    
    var numberOfPlayers: Int {
        return playerNames.count
    }
    let user: Int = 0
    var playerNames: [String]
    
    init() {
        self.playerNames = ["User", "Player 2", "Player 3"]
    }
    
    //MARK: - Getters
    func getCard(uuid: UUID?) -> Card? {
        if let suspect = getSuspect(uuid: uuid) {
            return suspect
        }
        
        if let weapond = getWeapond(uuid: uuid) {
            return weapond
        }
        
        if let room = getRoom(uuid: uuid) {
            return room
        }
        
        return nil
    }
    
    func getCardName(uuid: UUID?) -> String {
        if let card = getCard(uuid: uuid) {
            return card.name
        }
        
        return ""
    }
    
    func getSuspect(uuid: UUID?) -> Card? {
        for suspect in suspects {
            if(suspect.id == uuid) {
                return suspect
            }
        }
        
        return nil
    }
    
    func getSuspectName(uuid: UUID?) -> String {
        for suspect in suspects {
            if(suspect.id == uuid) {
                return suspect.name
            }
        }
        
        return ""
    }
    
    func getWeapond(uuid: UUID?) -> Card? {
        for weapond in weaponds {
            if(weapond.id == uuid) {
                return weapond
            }
        }
        
        return nil
    }
    
    func getWeapondName(uuid: UUID?) -> String {
        for weapond in weaponds {
            if(weapond.id == uuid) {
                return weapond.name
            }
        }
        
        return ""
    }
    
    func getRoom(uuid: UUID?) -> Card? {
        for room in rooms {
            if(room.id == uuid) {
                return room
            }
        }
        
        return nil
    }
    
    func getRoomName(uuid: UUID?) -> String {
        for room in rooms {
            if(room.id == uuid) {
                return room.name
            }
        }
        
        return ""
    }
    
    //MARK: - Adders
    func addInitalCards(ids: [UUID]) -> Bool {
        for id in ids {
            if let card = getCard(uuid: id) {
                card.setHave(to: user)
            } else {
                return false
            }
        }
        
        checkSheet()
        return true
    }
    
    mutating func addTurn(player: Int, asking: Int, suspectID: UUID?, weapondID: UUID?, roomID: UUID?, cardGave: CardType) -> Bool {
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
    
    func checkSheet() {
        var counter = suspects.count
        for suspect in suspects {
            if(suspect.isInocent) {
                counter -= 1
            }
        }
        
        if(counter == 1) {
            for suspect in suspects {
                if(!suspect.isInocent) {
                    suspect.dontHave = [0, 1, 2, 3, 4, 5]
                }
            }
        }
        
        counter = weaponds.count
        for weapond in weaponds {
            if(weapond.isInocent) {
                counter -= 1
            }
        }
        
        if(counter == 1) {
            for weapond in weaponds {
                if(!weapond.isInocent) {
                    weapond.dontHave = [0, 1, 2, 3, 4, 5]
                }
            }
        }
        
        counter = rooms.count
        for room in rooms {
            if(room.isInocent) {
                counter -= 1
            }
        }
        
        if(counter == 1) {
            for room in rooms {
                if(!room.isInocent) {
                    room.dontHave = [0, 1, 2, 3, 4, 5]
                }
            }
        }
    }
    
    //MARK: - Valid
    func validPlayer(_ index: Int) -> Bool {
        if(index >= 0 && index < numberOfPlayers) {
            return true
        }
        
        return false
    }
}

