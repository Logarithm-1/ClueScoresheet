//
//  MainGame.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct MainGameView: View {
    @Binding var game: Game
    
    @State var showSheet: Bool = false
    
    var body: some View {
        ZStack(alignment: Alignment.top) {
            TurnsView(game: $game)
            
            SlideOverCard {
                VStack {
                    Spacer().frame(height: 40)
                    SheetView(game: $game)
                }
            }
        }.navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct SheetPreviewView: View {
    @Binding var showSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                showSheet.toggle()
            } label: {
                Text("Show Sheet")
            }

        }
    }
}

struct MainGame_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView(game: .constant(Game()))
    }
}
