//
//  SelectCards.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct SelectCardsView: View {
    @EnvironmentObject var game: Game
    @State var selectedCardIds: [UUID] = [UUID]()
    
    @State var isTapped = false
    
    var body: some View {
        List {
            Section(header: Text("Suspects").font(.headline).foregroundColor(.primary)) {
                ForEach(game.suspects) { card in
                    SelectCardView(selectedCardIds: $selectedCardIds, card: card)
                }
            }
            
            Section(header: Text("Weaponds").font(.headline).foregroundColor(.primary)) {
                ForEach(game.weaponds) { card in
                    SelectCardView(selectedCardIds: $selectedCardIds, card: card)
                }
            }
            
            Section(header: Text("Rooms").font(.headline).foregroundColor(.primary)) {
                ForEach(game.rooms) { card in
                    SelectCardView(selectedCardIds: $selectedCardIds, card: card)
                }
            }
            
            Section {
                Button {
                    do {
                        try game.addInitialCards(ids: selectedCardIds)
                        print("added initial cards")
                        isTapped = true
                    } catch {
                        print("Can not add initial cards")
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Submit").bold().foregroundColor(.white)
                        Spacer()
                    }
                }.listRowBackground(Color.blue)
            }
            
            NavigationLink(destination: MainGameView().environmentObject(game), isActive: $isTapped) {
                Spacer().frame(height: 0)
            }.listRowBackground(Color.clear).hidden()
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Select Initial Cards")
    }
}

struct SelectCards_Previews: PreviewProvider {
    static var previews: some View {
        SelectCardsView()
    }
}
