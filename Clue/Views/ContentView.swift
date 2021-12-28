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
    @State var game: Game = Game()
    var body: some View {
        //NewGameView()
        MainGameView(game: $game)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
