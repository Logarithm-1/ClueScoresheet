//
//  TurnView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct TurnView: View {
    @Binding var game: Game
    @State var turnId: UUID
    
    let errorMessage: String = "Invalid Turn ID"
    
    var body: some View {
        if(game.getTurn(uuid: turnId) == nil) {
            Text(errorMessage)
        } else {
            Section(header: Text("Turn \(game.getTurnNumber(uuid: turnId))").font(.headline).foregroundColor(.primary)) {
                Text("Turn Player: ").bold() + Text("\(game.playerNames[game.getTurn(uuid: turnId)?.player ?? 0])")
                Text("Asked Player: ").bold() + Text("\(game.playerNames[game.getTurn(uuid: turnId)?.asking ?? 0])")
                Text("Suspect: ").bold() + Text("\(game.getTurn(uuid: turnId)?.suspect.name ?? errorMessage)")
                Text("Weapond: ").bold() + Text("\(game.getTurn(uuid: turnId)?.weapond.name ?? errorMessage)")
                Text("Room: ").bold() + Text("\(game.getTurn(uuid: turnId)?.room.name ?? errorMessage)")
                Text("Gave Card: ").bold() + Text("\(game.getTurn(uuid: turnId)?.cardGaveToString() ?? errorMessage)")
            }
        }
    }
}

struct TurnView_Previews: PreviewProvider {
    static var previews: some View {
        TurnView(game: .constant(Game()), turnId: UUID())
    }
}
