//
//  NewGameView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct NewGameView: View {
    @State var game: Game = Game()
    
    let maxNumberOfPlayers: Int = 6
    let minNumberOfPlayers: Int = 2
    
    var body: some View {
        NavigationView {
            List {
                Stepper("\(game.numberOfPlayers) Players") {
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
                
                NavigationLink(destination: SelectCardsView(game: $game)) {
                    Button(action: {
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Submit").bold().foregroundColor(Color.white)
                            Spacer()
                        }
                    }).buttonStyle(RoundedRectangleButtonStyle())
                }
            }.listStyle(InsetGroupedListStyle())
        }
    }
}

struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.black)
            Spacer()
        }
        .padding()
        .background(Color.blue.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
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
