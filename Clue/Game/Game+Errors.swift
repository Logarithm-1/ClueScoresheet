//
//  Game+Error.swift
//  Clue
//
//  Created by Logan Richards on 12/31/21.
//

import Foundation

//TODO: Add prompts for errors

extension Game {
    enum CardError : Error {
        case invalidUUID
    }
    
    enum TurnError : Error {
        case playerAskingEqual
        case invalidPlayer
        case invalidAsking
        case invalidSuspect
        case invalidWeapond
        case invalidRoom
        case userKnownsCard
    }
    
    enum GameError : Error {
        case someoneCheated
    }
}
