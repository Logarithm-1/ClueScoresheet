//
//  Game.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import Foundation

class Game: ObservableObject {
    @Published var cards: [Card] = [Card(name: "Colonel Mustard", imageName: "colonelMusard", cardType: .Suspect),
                         Card(name: "Professor Plum", imageName: "professorPlum", cardType: .Suspect),
                         Card(name: "Mr. Green", imageName: "mrGreen", cardType: .Suspect),
                         Card(name: "Mrs. Peacock", imageName: "mrsPeacock", cardType: .Suspect),
                         Card(name: "Miss scarlet", imageName: "missScarlet", cardType: .Suspect),
                         Card(name: "Mrs. White", imageName: "mrsWhite", cardType: .Suspect),
                         Card(name: "Knife", imageName: "knife", cardType: .Weapond),
                         Card(name: "Candle Stick", imageName: "candleStick", cardType: .Weapond),
                         Card(name: "Revolver", imageName: "revolver", cardType: .Weapond),
                         Card(name: "Rope", imageName: "rope", cardType: .Weapond),
                         Card(name: "Lead Pipe", imageName: "leadPipe", cardType: .Weapond),
                         Card(name: "Wrench", imageName: "wrench", cardType: .Weapond),
                         Card(name: "Hall", imageName: "hall", cardType: .Room),
                         Card(name: "Lounge", imageName: "lounge", cardType: .Room),
                         Card(name: "Dinning Room", imageName: "dinning", cardType: .Room),
                         Card(name: "Kitchen", imageName: "kitchen", cardType: .Room),
                         Card(name: "Ball Room", imageName: "ball", cardType: .Room),
                         Card(name: "Conservatorty", imageName: "conservatory", cardType: .Room),
                         Card(name: "Billiard Room", imageName: "billiard", cardType: .Room),
                         Card(name: "Library", imageName: "library", cardType: .Room),
                         Card(name: "Study", imageName: "study", cardType: .Room)]
    
    var suspects: [Card] {
        var suspects = [Card]()
        
        for card in cards {
            if(card.cardType == .Suspect) {
                suspects.append(card)
            }
        }
        
        return suspects
    }
    
    var weaponds: [Card] {
        var weaponds = [Card]()
        
        for card in cards {
            if(card.cardType == .Weapond) {
                weaponds.append(card)
            }
        }
        
        return weaponds
    }
    
    var rooms: [Card] {
        var rooms = [Card]()
        
        for card in cards {
            if(card.cardType == .Room) {
                rooms.append(card)
            }
        }
        
        return rooms
    }
    
    var turns: [Turn] = [Turn]()
    
    var numberOfPlayers: Int {
        return playerNames.count
    }
    let user: Int = 0
    @Published var playerNames: [String]
    
    //var guiltySuspect: (suspect: Card, probability: Float) = (suspect: Card(name: "Invalid", imageName: "invalid"), probability: 1.0)
    
    //var guiltyWeapond: (weapond: Card, probability: Float) = (weapond: Card(name: "Invalid", imageName: "invalid"), probability: 1.0)
    
    //var guiltyRoom: (room: Card, probability: Float) = (room: Card(name: "Invalid", imageName: "invalid"), probability: 1.0)
    
    init() {
        self.playerNames = ["User", "Player 2", "Player 3"]
        //self.checkSheet()
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
    /*
    //MARK: - Adders
    
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
        
        //Recaculate Proabilities
        calculateSuspectProbabilities()
        calculateWeapondProbabilities()
        calculateRoomProbabilities()
    }
    
    func calculateSuspectProbabilities() {
        var numberOfSuspects: Int = suspects.count
        
        for suspect in suspects {
            if(suspect.isGuilty) {
                self.guiltySuspect = (suspect: suspect, probability: 1.0)
                return
            } else if(suspect.isInocent) {
                numberOfSuspects -= 1
            }
        }
        
        var maxProbability: Float = 0.0
        var maxIndex: Int = 0
        
        for i in 0..<suspects.count {
            if(!suspects[i].isInocent) {
                let probability: Float = 1 / Float(numberOfSuspects)
                if(probability > maxProbability) {
                    maxProbability = probability
                    maxIndex = i
                }
            }
        }
        
        self.guiltySuspect = (suspect: suspects[maxIndex], probability: maxProbability)
    }
    
    func calculateWeapondProbabilities() {
        var numberOfWeaponds: Int = suspects.count
        
        for weapond in weaponds {
            if(weapond.isGuilty) {
                self.guiltyWeapond = (weapond: weapond, probability: 1.0)
                return
            } else if(weapond.isInocent) {
                numberOfWeaponds -= 1
            }
        }
        
        var maxProbability: Float = 0.0
        var maxIndex: Int = 0
        
        for i in 0..<weaponds.count {
            if(!weaponds[i].isInocent) {
                let probability: Float = 1 / Float(numberOfWeaponds)
                if(probability > maxProbability) {
                    maxProbability = probability
                    maxIndex = i
                }
            }
        }
        
        self.guiltyWeapond = (weapond: weaponds[maxIndex], probability: maxProbability)
    }
    
    func calculateRoomProbabilities() {
        var numberOfRooms: Int = suspects.count
        
        for room in rooms {
            if(room.isGuilty) {
                self.guiltyRoom = (room: room, probability: 1.0)
                return
            } else if(room.isInocent) {
                numberOfRooms -= 1
            }
        }
        
        var maxProbability: Float = 0.0
        var maxIndex: Int = 0
        
        for i in 0..<rooms.count {
            if(!rooms[i].isInocent) {
                let probability: Float = 1 / Float(numberOfRooms)
                if(probability > maxProbability) {
                    maxProbability = probability
                    maxIndex = i
                }
            }
        }
        
        self.guiltyRoom = (room: rooms[maxIndex], probability: maxProbability)
    }
    
    //MARK: - Valid
    func validPlayer(_ index: Int) -> Bool {
        if(index >= 0 && index < numberOfPlayers) {
            return true
        }
        
        return false
    }*/
}
