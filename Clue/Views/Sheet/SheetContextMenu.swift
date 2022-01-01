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
    
    var body: some View {
        ForEach(0..<game.numberOfPlayers) { player in
            Section {
                Text(game.playerNames[player]).bold()
                
                Button {
                    do {
                        try game.setCardHave(to: player, for: cardID)
                    } catch {
                        //TODO: Prompt
                        print("Can not set card to have player")
                    }
                } label: {
                    Text("Have")
                }
                
                if(player != 0) {
                    Button {
                        do {
                            try game.addCardMightHave(player: player, for: cardID)
                        } catch {
                            //TODO: Prompt
                            print("Can not set card to might have player")
                        }
                    } label: {
                        Text("Might Have")
                    }
                }
                
                Button {
                    do {
                        try game.addCardDontHave(player: player, for: cardID)
                    } catch {
                        //TODO: Prompt
                        print("Can not set card to dont have player")
                    }
                } label: {
                    Text("Don't Have")
                }
            }
        }
    }
}

struct SheetContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        SheetContextMenu(cardID: UUID())
    }
}
