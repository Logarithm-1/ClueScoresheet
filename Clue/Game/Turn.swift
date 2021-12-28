//
//  Turn.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import Foundation

struct Turn: Identifiable {
    let id = UUID()
    let player: Int
    let suspect: Card
    let weapond: Card
    let room: Card
    
    let asking: Int
    let cardGave: CardType
}
