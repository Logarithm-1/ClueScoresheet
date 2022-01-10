//
//  NewGameView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct NewGameView: View {
    @StateObject var game: Game = Game()
    
    let maxNumberOfPlayers: Int = 6
    let minNumberOfPlayers: Int = 2
    
    var body: some View {
        NavigationView {
            List {
                Stepper("\(game.playerNames.count) Players") {
                    if(game.numberOfPlayers < maxNumberOfPlayers) {
                        game.playerNames.append("Player \(game.numberOfPlayers + 1)")
                    }
                } onDecrement: {
                    if(game.numberOfPlayers > minNumberOfPlayers) {
                        game.playerNames.removeLast()
                    }
                }
                
                Section(header: Text("Player Names").font(.headline).foregroundColor(.primary)) {
                    NewGamePlayerNamesView(names: $game.playerNames)
                }
                
                NavigationLink(isActive: $game.selectingInitialCards) {
                    SelectCardsView().environmentObject(game)
                } label: {
                    HStack {
                        Spacer()
                        Text("Submit").bold().foregroundColor(Color.white)
                        Spacer()
                    }
                }.listRowBackground(Color.blue)

            }.listStyle(InsetGroupedListStyle())
                .navigationTitle("New Game")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NewGamePlayerNamesView: View {
    @Binding var names: [String]
    
    var body: some View {
        ForEach($names, id:\.self) { name in
            TextField("Player Name", text: name)
        }
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView()
    }
}
