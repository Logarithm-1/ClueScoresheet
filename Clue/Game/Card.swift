//
//  Card.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import Foundation
class Card : Identifiable {
    let id: UUID
    let name: String
    let imageName: String
    
    var have: Int
    var mightHave: [Int]
    var dontHave: [Int]
    
    var isGuilty: Bool {
        return dontHave.count == 6
    }
    
    var isInocent: Bool {
        return (have >= 0)
    }
    
    init(name: String, imageName: String) {
        self.id = UUID()
        self.name = name
        self.imageName = imageName
        
        self.have = -1
        self.mightHave = [Int]()
        self.dontHave = [Int]()
    }
    
    func addToDontHave(player: Int) {
        if(have < 0 && !dontHave.contains(player)) {
            dontHave.append(player)
        }
    }
    
    func addToMightHave(player: Int) {
        if(have < 0 && !mightHave.contains(player)) {
            mightHave.append(player)
        }
    }
    
    func setHave(to player: Int) {
        have = player
        mightHave = [Int]()
        dontHave = [0, 1, 2, 3, 4, 5]
        dontHave.removeAll { i in
            return i == player
        }
    }
}
