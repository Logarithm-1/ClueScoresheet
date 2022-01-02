//
//  SheetView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var game: Game
    
    var colorInocent: Color {
        return colorScheme == .light ? Color.green : Color.darkGreen
    }
    
    var colorGuilty: Color {
        return colorScheme == .light ? Color.red : Color.darkRed
    }
    
    var body: some View {
        List {
            Section(header: Text("Suspects").font(.headline).foregroundColor(.primary)) {
                ForEach(game.suspects) { card in
                    SheetCardView(cardID: card.id)
                        .listRowBackground(card.isInocent ? colorInocent : card.isGuilty ? colorGuilty : nil)
                }
            }
            
            Section(header: Text("Weaponds").font(.headline).foregroundColor(.primary)) {
                ForEach(game.weaponds) { card in
                    SheetCardView(cardID: card.id)
                        .listRowBackground(card.isInocent ? colorInocent : card.isGuilty ? colorGuilty : nil)
                }
            }
            
            Section(header: Text("Rooms").font(.headline).foregroundColor(.primary)) {
                ForEach(game.rooms) { card in
                    SheetCardView(cardID: card.id)
                        .listRowBackground(card.isInocent ? colorInocent : card.isGuilty ? colorGuilty : nil)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}

