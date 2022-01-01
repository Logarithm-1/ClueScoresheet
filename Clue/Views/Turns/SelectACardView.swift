//
//  SelectACardView.swift
//  Clue
//
//  Created by Logan Richards on 1/1/22.
//

import SwiftUI

struct SelectACardView: View {
    @EnvironmentObject var game: Game
    var title: String
    @Binding var cardID: UUID?
    var placeholder: String
    var cardType: Game.CardType
    
    var body: some View {
        HStack {
            Text(title).bold()
            
            Menu {
                ForEach(cardType == .Suspect ? game.suspects : cardType == .Weapond ? game.weaponds : cardType == .Room ? game.rooms : game.cards) { card in
                    Button(card.name) {
                        cardID = card.id
                    }
                }
            } label: {
                HStack {
                    if let card = game.getCard(uuid: cardID) {
                        Text(card.name).foregroundColor(.primary)
                    } else {
                        Text(placeholder).foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.blue)
                        .font(.headline)
                }
            }
        }
    }
}

struct SelectACardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectACardView(title: "Suspect", cardID: .constant(UUID()), placeholder: "Suspect", cardType: .Suspect)
    }
}
