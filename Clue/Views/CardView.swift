//
//  ItemView.swift
//  Clue
//
//  Created by Logan Richards on 12/26/21.
//

import SwiftUI

struct CardView: View {
    @Binding var game: Game
    @Binding var item: Card
    
    func createMightHaveOutput() -> String {
        var str: String = ""
        var addCommaBefore: Bool = false
        
        for i in 0..<item.mightHave.count {
            if(item.mightHave[i] < game.numberOfPlayers) {
                if(addCommaBefore) {
                    str += ", "
                } else {
                    addCommaBefore = true
                }
                
                str += game.playerNames[item.mightHave[i]]
            }
        }
        return str
    }
    
    func createDontHaveOutput() -> String {
        var str: String = ""
        var addCommaBefore: Bool = false
        
        for i in 0..<item.dontHave.count {
            if(item.dontHave[i] < game.numberOfPlayers) {
                if(addCommaBefore) {
                    str += ", "
                } else {
                    addCommaBefore = true
                }
                str += game.playerNames[item.dontHave[i]]
            }
        }
        return str
    }
    
    var body: some View {
        HStack {
            Image(item.imageName).resizable().aspectRatio(1, contentMode: .fit).frame(maxWidth: 40).clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(item.name)
                
                if(item.isInocent) { //Someone owns the card
                    Text(game.playerNames[item.have]).foregroundColor(.secondary)
                } else if(item.isGuilty) { //Noone ones the card
                    Text("GUILTY").foregroundColor(.secondary)
                } else { //Unclear
                    if(createMightHaveOutput() != "") {
                        Text("Might Have: " + createMightHaveOutput()).foregroundColor(.secondary)
                    }
                    
                    if(createDontHaveOutput() != "") {
                        Text("Dont Have: " + createDontHaveOutput()).foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(game: .constant(Game()), item: .constant(Card(name: "Mrs. White", imageName: "mrsWhite")))
    }
}
