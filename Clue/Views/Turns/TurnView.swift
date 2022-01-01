//
//  TurnView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct TurnView: View {
    @EnvironmentObject var game: Game
    @State var turnID: UUID
    
    let errorMessage: String = "Invalid Turn ID"
    
    var body: some View {
        if let turn = game.getTurn(uuid: turnID) {
            Section(header: Text("Turn \(game.getTurnNumber(uuid: turnID))")) {
                Text("Turn Player: ").bold() + Text(game.playerNames[turn.player])
                Text("Asked Player: ").bold() + Text(game.playerNames[turn.asking])
                Text("Suspect: ").bold() + Text(turn.suspect.name)
                Text("Weapond: ").bold() + Text(turn.weapond.name)
                Text("Room: ").bold() + Text(turn.room.name)
                Text("Card Gave: ").bold() + Text(turn.cardGaveToString())
            }
        } else {
            Text(errorMessage)
        }
    }
}

struct TurnView_Previews: PreviewProvider {
    static var previews: some View {
        TurnView(turnID: UUID())
    }
}
