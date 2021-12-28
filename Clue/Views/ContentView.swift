//
//  ContentView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

//New Game
//Number of Players + Player Names
//Insert the cards you got

//Add Turn
//Sheet View

struct ContentView: View {
    @State var game: Game = Game(numberOfPlayers: 3, playerNames: ["Me", "Player 1", "Player 2"])
    
    var body: some View {
        TabView {
            NewGameView().tabItem {
                Label("1", systemImage: "")
            }
            
            SelectCardsView(game: $game).tabItem {
                Label("2", systemImage: "")
            }
            
            TurnsView(game: $game).tabItem {
                Label("Turns", systemImage: "")
            }
            
            SheetView(game: $game).tabItem {
                Label("Sheet", systemImage: "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
