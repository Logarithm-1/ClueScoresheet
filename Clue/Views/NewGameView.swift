//
//  NewGameView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct NewGameView: View {
    let maxNumberOfPlayers: Int = 6
    let minNumberOfPlayers: Int = 2
    
    @State var numberOfPlayers: Int = 3
    @State var playerNames: [String] = ["Me", "", "", "", "", ""]
    
    var body: some View {
        VStack {
            Stepper("\(numberOfPlayers) Players") {
                if(numberOfPlayers < maxNumberOfPlayers) {
                    numberOfPlayers += 1
                }
            } onDecrement: {
                if(numberOfPlayers > minNumberOfPlayers) {
                    numberOfPlayers -= 1
                }
            }
            
            ForEach(0..<numberOfPlayers) { player in
                TextField("Player \(player)", text: $playerNames[player])
            }
            
        }
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView()
    }
}
