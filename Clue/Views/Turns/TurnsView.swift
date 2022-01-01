//
//  TurnsView.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct TurnsView: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        List {
            Section(header: Text("Add Turn").font(.headline).foregroundColor(.primary)) {
                AddTurnView()
            }
            
            ForEach(game.turns) { turn in
                TurnView(turnID: turn.id)
            }
        }
    }
}

struct TurnsView_Previews: PreviewProvider {
    static var previews: some View {
        TurnsView()
    }
}
