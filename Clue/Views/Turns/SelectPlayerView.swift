//
//  SelectPlayerView.swift
//  Clue
//
//  Created by Logan Richards on 1/1/22.
//

import SwiftUI

struct SelectPlayerView: View {
    @EnvironmentObject var game: Game
    var title: String
    @Binding var player: Int
    var placeholder = "Player"
    
    
    var body: some View {
        HStack {
            Text(title).bold()
            Menu {
                ForEach(0..<game.numberOfPlayers) { player in
                    Button(game.playerNames[player]) {
                        self.player = player
                    }
                }
            } label: {
                HStack {
                    Text(game.validPlayer(num: player) ? game.playerNames[player] : placeholder)
                        .foregroundColor(game.validPlayer(num: player) ? .primary : .secondary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.blue)
                        .font(.headline)
                }
            }
        }
    }
}

struct SelectPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerView(title: "Player", player: .constant(1))
    }
}
