//
//  SelectCardView.swift
//  Clue
//
//  Created by Logan Richards on 12/31/21.
//

import SwiftUI

struct SelectCardView: View {
    @Binding var selectedCardIds: [UUID]
    var card: Game.Card
    
    @State var selected: Bool = false
    
    var body: some View {
        HStack {
            Image(card.imageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 40)
                .clipShape(Circle())
            Text(card.name)
            Spacer()
            Button {
                if(selectedCardIds.contains(card.id)) { //card is selected
                    selectedCardIds.removeAll { id in
                        return card.id == id
                    }
                    selected = false
                } else {
                    selectedCardIds.append(card.id)
                    selected = true
                }
            } label: {
                if(selected) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .padding(5)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: 40)
                } else {
                    Image(systemName: "circle")
                        .resizable()
                        .padding(5)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: 40)
                }
            }.foregroundColor(.primary)

        }
    }
}

struct SelectCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCardView(selectedCardIds: .constant([UUID]()), card: Game.Card(name: "", imageName: "", cardType: .Weapond))
    }
}
