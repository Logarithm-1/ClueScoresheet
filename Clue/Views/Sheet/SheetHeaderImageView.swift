//
//  SheetHeaderImageView.swift
//  Clue
//
//  Created by Logan Richards on 1/1/22.
//

import SwiftUI

struct SheetHeaderImageView: View {
    @EnvironmentObject var game: Game
    @Binding var cardID: UUID
    
    var body: some View {
        ZStack {
            if let card = game.getCard(uuid: cardID) {
                CirclarProgrossBar(progress: 1)
                    .stroke(Color.midnightBlue, lineWidth: 5)
                CirclarProgrossBar(progress: CGFloat(card.probabilityGuilty))
                    .stroke(card.isGuilty ? Color.green : Color.blue, lineWidth: 5)
                Group {
                    Image(card.imageName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(Circle())
                }.padding(5)
            }
        }
    }
}

struct SheetHeaderImageView_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderImageView(cardID: .constant(UUID()))
    }
}
