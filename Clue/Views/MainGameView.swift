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
        
        ZStack {
            TurnsView()
            
            SlideOverCard {
                VStack {
                    SheetHeaderView()
                        .frame(height: 50)
                    SheetView()
                    Spacer()
                        .frame(height: 200)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct MainGame_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}
