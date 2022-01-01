//
//  ItemView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct SheetCardView: View {
    @EnvironmentObject var game: Game
    var cardID: UUID
    
    var body: some View {
        HStack {
            if let card = game.getCard(uuid: cardID) {
                Image(card.imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(game.getCardName(uuid: cardID)).bold()
                    
                    Group {
                        if(card.isInocent) { //Someone owns the card
                            Text(game.playerNames[card.have])
                        } else if(card.isGuilty) { //No one owns the card
                            Text("GUILTY")
                        } else { //Unclear
                            if(card.mightHave.count != 0) {
                                Text("Might Have: ").bold() + Text(game.getCardMightHave(uuid: cardID))
                            }
                            
                            if(card.dontHave.count != 0) {
                                Text("Don't Have: ").bold() + Text(game.getCardDontHave(uuid: cardID))
                            }
                        }
                    }.foregroundColor(.secondary)
                }
                
                //Text % chance guilty (and or) % chance inocent
            } else {
                Text("Error getting card")
            }
        }.contextMenu {
            SheetContextMenu(cardID: cardID).environmentObject(game)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        SheetCardView(cardID: UUID())
    }
}
