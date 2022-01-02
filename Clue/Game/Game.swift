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
    
    @Published var turns: [Turn] = [Turn]()
    
    var numberOfPlayers: Int {
        return playerNames.count
    }
    let user: Int = 0
    @Published var playerNames: [String]
    
    let minNumberOfPlayers: Int = 2
    let maxNumberOfPlayers: Int = 6
    
    @Published var mostGuiltySuspect: UUID = UUID()
    @Published var mostGuiltyWeapond: UUID = UUID()
    @Published var mostGuiltyRoom: UUID = UUID()
    
    init() {
        self.playerNames = ["User", "Player 2", "Player 3"]
        
        for i in 0..<cards.count {
            var playerIds: [Int] = [Int]()
            playerIds.append(user)
            
            for player in numberOfPlayers..<maxNumberOfPlayers {
                playerIds.append(player)
            }
        }
    }
    
    //MARK: - Validate
    func validPlayer(num: Int) -> Bool {
        if(num >= 0 && num < numberOfPlayers) {
            return true
        }
        
        return false
    }
}
