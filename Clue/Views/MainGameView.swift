//
//  MainGame.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct MainGameView: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        SlideOverCard {
            TurnsView()
        } content: {
            SheetView()
        } header: {
            SheetHeaderView()
        }
        .navigationBarBackButtonHidden(true)
        //.navigationBarHidden(true)
        .navigationTitle("Turns")
        .toolbar {
            Text("New Game")
        }
    }
}

struct MainGame_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}
