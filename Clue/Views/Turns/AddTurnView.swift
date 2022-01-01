//
//  AddTurnView.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct AddTurnView: View {
    @EnvironmentObject var game: Game
    
    @State var player: Int = -1
    @State var asking: Int = -1
    @State var suspectID: UUID?
    @State var weapondID: UUID?
    @State var roomID: UUID?
    @State var gaveAny: Bool = false
    
    @State var cardGave: Game.CardType = .Unknown
    
    var body: some View {
        SelectPlayerView(title: "Current Player:", player: $player)
        SelectPlayerView(title: "Asking:", player: $asking)
        SelectACardView(title: "Suspect:", cardID: $suspectID, placeholder: "Suspect", cardType: .Suspect)
        SelectACardView(title: "Weapond:", cardID: $weapondID, placeholder: "Weapond", cardType: .Weapond)
        SelectACardView(title: "Room:", cardID: $roomID, placeholder: "Room", cardType: .Room)
        
        if(player == game.user) {
            SelectCardGaveView(title: "Card Gave:", cardType: $cardGave, suspectID: $suspectID, weapondID: $weapondID, roomID: $roomID)
        } else {
            Toggle("Asking Gave Any Cards?", isOn: $gaveAny)
        }
        
        Button {
            if(player != game.user && gaveAny) {
                cardGave = .Unknown
            } else if(player != game.user) {
                cardGave = .None
            }
            
            do {
                try game.addTurn(player: player, asking: asking, suspectID: suspectID, weapondID: weapondID, roomID: roomID, cardGave: cardGave)
            } catch {
                print(error)
            }
        } label: {
            HStack {
                Spacer()
                Text("Add").bold().foregroundColor(.white)
                Spacer()
            }
        }.listRowBackground(Color.blue)
    }
}

struct AddTurnView_Previews: PreviewProvider {
    static var previews: some View {
        AddTurnView()
    }
}
