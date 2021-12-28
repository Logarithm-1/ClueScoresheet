//
//  SheetView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct SheetView: View {
    @Binding var game: Game
    
    var body: some View {
        List {
            Section(header: Text("People").font(.headline).foregroundColor(.primary)) {
                ForEach(0..<game.suspects.count) { i in
                    CardView(game: $game, item: $game.suspects[i])
                        .listRowBackground(game.suspects[i].isInocent ? Color.green : game.suspects[i].isGuilty ? Color.red : Color.white)
                }
            }
            
            Section(header: Text("Weaponds").font(.headline).foregroundColor(.primary)) {
                ForEach(0..<game.weaponds.count) { i in
                    CardView(game: $game, item: $game.weaponds[i])
                        .listRowBackground(game.weaponds[i].isInocent ? Color.green : game.weaponds[i].isGuilty ? Color.red : Color.white)
                }
            }
            
            Section(header: Text("Rooms").font(.headline).foregroundColor(.primary)) {
                ForEach(0..<game.rooms.count) { i in
                    CardView(game: $game, item: $game.rooms[i])
                        .listRowBackground(game.rooms[i].isInocent ? Color.green : game.rooms[i].isGuilty ? Color.red : Color.white)
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(game: .constant(Game(numberOfPlayers: 3, playerNames: ["Logan", "Aspen", "Dad"])))
    }
}
