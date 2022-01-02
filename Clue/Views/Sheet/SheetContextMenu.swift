//
//  SheetContextMenu.swift
//  Clue
//
//  Created by Logan Richards on 12/31/21.
//

import SwiftUI

struct SheetContextMenu: View {
    @EnvironmentObject var game: Game
    var cardID: UUID
    
    @State var alertMessage: String = "Sorry. Something went wrong."
    @State var showingAlert: Bool = false
    
    var body: some View {
        ForEach(0..<game.numberOfPlayers) { player in
            Section {
                Text(game.playerNames[player]).bold()
                
                Button {
                    do {
                        try game.setCardHave(to: player, for: cardID)
                    } catch Game.CardError.invalidUUID {
                        alertMessage = "Sorry there is trouble editing card information. Please check data and try again."
                        showingAlert = true
                    } catch {
                        alertMessage = "Sorry. Something went wrong. \(error)"
                        showingAlert = true
                    }
                } label: {
                    Text("Have")
                }
                
                if(player != 0) {
                    Button {
                        do {
                            try game.addCardMightHave(player: player, for: cardID)
                        } catch Game.CardError.invalidUUID {
                            alertMessage = "Sorry there is trouble editing card information. Please check data and try again."
                            showingAlert = true
                        } catch {
                            alertMessage = "Sorry. Something went wrong. \(error)"
                            showingAlert = true
                        }
                    } label: {
                        Text("Might Have")
                    }
                }
                
                Button {
                    do {
                        try game.addCardDontHave(player: player, for: cardID)
                    } catch Game.CardError.invalidUUID {
                        alertMessage = "Sorry there is trouble editing card information. Please check data and try again."
                        showingAlert = true
                    } catch {
                        alertMessage = "Sorry. Something went wrong. \(error)"
                        showingAlert = true
                    }
                } label: {
                    Text("Don't Have")
                }
            }.alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

struct SheetContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        SheetContextMenu(cardID: UUID())
    }
}
