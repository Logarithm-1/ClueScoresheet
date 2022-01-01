//
//  SwiftUIView.swift
//  Clue
//
//  Created by Logan Richards on 1/1/22.
//

import SwiftUI

struct SelectCardGaveView: View {
    @EnvironmentObject var game: Game
    var title: String
    @Binding var cardType: Game.CardType
    @Binding var suspectID: UUID?
    @Binding var weapondID: UUID?
    @Binding var roomID: UUID?
    var placeholder = "Select Card They Gave"
    
    var body: some View {
        HStack {
            Text(title).bold()
            
            Menu {
                Section {
                    Button("No Card Given") {
                        self.cardType = .None
                    }
                }
                
                if let card = game.getCard(uuid: suspectID) {
                    Button(card.name) {
                        self.cardType = .Suspect
                    }
                } else {
                    Text("Please Select Suspect")
                }
                
                if let card = game.getCard(uuid: weapondID) {
                    Button(card.name) {
                        self.cardType = .Weapond
                    }
                } else {
                    Text("Please Select Weapond")
                }
                
                if let card = game.getCard(uuid: roomID) {
                    Button(card.name) {
                        self.cardType = .Room
                    }
                } else {
                    Text("Please Select Room")
                }
            } label: {
                HStack {
                    switch cardType {
                    case .Suspect, .Weapond, .Room:
                        Text(game.getCardName(uuid: suspectID))
                            .foregroundColor(.primary)
                    case .None:
                        Text("No Card Given")
                            .foregroundColor(.primary)
                    default:
                        Text(placeholder)
                            .foregroundColor(.secondary)
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCardGaveView(title: "Card Gave:", cardType: .constant(.None), suspectID: .constant(UUID()), weapondID: .constant(UUID()), roomID: .constant(UUID()))
    }
}
