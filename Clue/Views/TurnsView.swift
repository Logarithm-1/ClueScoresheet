//
//  TurnsView.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct TurnsView: View {
    @Binding var game: Game
    
    var body: some View {
        List {
            AddTurnView(game: $game)
            
            Section(header: Text("Previous Turns")) {
                ForEach(game.turns.reversed()) { turn in
                    TurnView(turn: turn)
                }
            }
        }
    }
}

struct TurnsView_Previews: PreviewProvider {
    static var previews: some View {
        TurnsView(game: .constant(Game(numberOfPlayers: 3, playerNames: ["Me", "Player 1", "Player 2"])))
    }
}
