//
//  SheetHeaderView.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct SheetHeaderView: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        HStack {
            SheetHeaderImageView(cardID: $game.mostGuiltySuspect)
            SheetHeaderImageView(cardID: $game.mostGuiltyWeapond)
            SheetHeaderImageView(cardID: $game.mostGuiltyRoom)
        }.padding(5)
    }
}

struct SheetHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderView().frame(height: 60)
    }
}
