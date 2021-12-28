//
//  TurnView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct TurnView: View {
    @State var turn: Turn
    
    var body: some View {
        VStack {
            Text("Player \(turn.player)")
            Text("Asking \(turn.asking)")
            Text("Suspect: \(turn.suspect.name)")
            Text("Weapond: \(turn.weapond.name)")
            Text("Room: \(turn.room.name)")
        }
    }
}

struct TurnView_Previews: PreviewProvider {
    static var previews: some View {
        TurnView(turn: Turn(player: 0, suspect: Card(name: "k", imageName: ""), weapond: Card(name: "w", imageName: ""), room: Card(name: "room", imageName: ""), asking: 1, cardGave: .Unknown))
    }
}
