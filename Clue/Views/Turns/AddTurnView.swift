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
    
    @State private var alertMessage: String = "Sorry. Something went wrong."
    @State private var showingAlert = false
    
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
            let tempCardGave: Game.CardType = cardGave
            if(player != game.user && gaveAny) {
                cardGave = .Unknown
            } else if(player != game.user) {
                cardGave = .None
            }
            
            do {
                try game.addTurn(player: player, asking: asking, suspectID: suspectID, weapondID: weapondID, roomID: roomID, cardGave: cardGave)
                //Turn Rotation
                player += 1
                player %= game.numberOfPlayers
                asking = -1
                suspectID = nil
                weapondID = nil
                roomID = nil
                cardGave = .Unknown
                return
            } catch Game.CardError.invalidUUID {
                alertMessage = "Sorry there is trouble editing card information. Please check data and try again."
                showingAlert = true
            } catch Game.TurnError.playerAskingEqual {
                alertMessage = "The Current Player and the player asking must not be the same."
                showingAlert = true
            } catch Game.TurnError.invalidPlayer {
                alertMessage = "Please select the current player."
                showingAlert = true
            } catch Game.TurnError.invalidAsking {
                alertMessage = "Please select the player asked."
                showingAlert = true
            } catch Game.TurnError.invalidSuspect {
                alertMessage = "Please select the suspect asked about."
                showingAlert = true
            } catch Game.TurnError.invalidWeapond {
                alertMessage = "Please select the weapond asked about."
                showingAlert = true
            } catch Game.TurnError.invalidRoom {
                alertMessage = "Please select the room asked about."
                showingAlert = true
            } catch Game.TurnError.userKnownsCard {
                alertMessage = "Please select the card that the player gave."
                showingAlert = true
            } catch Game.GameError.someoneCheated {
                alertMessage = "Please check cards. Data might have been inputed incorrectly or someone might have cheated."
                showingAlert = true
            } catch {
                alertMessage = "Sorry. Something went wrong. \(error)"
                showingAlert = true
            }
            
            if(cardGave != tempCardGave) {
                cardGave = tempCardGave
            }
            
        } label: {
            HStack {
                Spacer()
                Text("Add").bold().foregroundColor(.white)
                Spacer()
            }
        }.listRowBackground(Color.blue)
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        
    }
}

struct AddTurnView_Previews: PreviewProvider {
    static var previews: some View {
        AddTurnView()
    }
}
