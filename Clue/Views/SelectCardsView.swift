//
//  SelectCards.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct SelectCardsView: View {
    @Binding var game: Game
    @State var selectedCardIds: [UUID] = [UUID]()
    
    var body: some View {
        List {
            Section(header: Text("People").font(.headline).foregroundColor(.primary)) {
                ForEach(0..<game.suspects.count) { i in
                    HStack {
                        CardView(game: $game, item: $game.suspects[i])
                        Spacer()
                        Button {
                            if(selectedCardIds.contains(game.suspects[i].id)) {
                                selectedCardIds.removeAll { id in
                                    return game.suspects[i].id == id
                                }
                            } else {
                                selectedCardIds.append(game.suspects[i].id)
                            }
                        } label: {
                            if(selectedCardIds.contains(game.suspects[i].id)) {
                                Image(systemName: "checkmark.circle.fill")
                            } else {
                                Image(systemName: "circle")
                            }
                        }
                        
                    }
                }
            }
            
            Section(header: Text("Weaponds").font(.headline).foregroundColor(.primary)) {
                ForEach(0..<game.weaponds.count) { i in
                    HStack {
                        CardView(game: $game, item: $game.weaponds[i])
                        Spacer()
                        Button {
                            if(selectedCardIds.contains(game.weaponds[i].id)) {
                                selectedCardIds.removeAll { id in
                                    return game.weaponds[i].id == id
                                }
                            } else {
                                selectedCardIds.append(game.weaponds[i].id)
                            }
                        } label: {
                            if(selectedCardIds.contains(game.weaponds[i].id)) {
                                Image(systemName: "checkmark.circle.fill")
                            } else {
                                Image(systemName: "circle")
                            }
                        }
                    }
                }
            }
            
            Section(header: Text("Rooms").font(.headline).foregroundColor(.primary)) {
                ForEach(0..<game.rooms.count) { i in
                    HStack {
                        CardView(game: $game, item: $game.rooms[i])
                        Spacer()
                        Button {
                            if(selectedCardIds.contains(game.rooms[i].id)) {
                                selectedCardIds.removeAll { id in
                                    return game.rooms[i].id == id
                                }
                            } else {
                                selectedCardIds.append(game.rooms[i].id)
                            }
                        } label: {
                            if(selectedCardIds.contains(game.rooms[i].id)) {
                                Image(systemName: "checkmark.circle.fill")
                            } else {
                                Image(systemName: "circle")
                            }
                        }
                    }
                }
            }
            
            NavigationLink(destination: MainGameView(game: $game)) {
                HStack {
                    Spacer()
                    Text("Submit").bold()
                    Spacer()
                }.foregroundColor(Color.white)
            }.listRowBackground(Color.blue)
                .simultaneousGesture(TapGesture().onEnded{
                    if(game.addInitalCards(ids: selectedCardIds)) {
                        //All is good
                    } else {
                        //Error when adding card -> Prompt
                        print("Invalid selected id")
                    }
                })
        }.listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Select Your Cards")
    }
}

struct SelectCards_Previews: PreviewProvider {
    static var previews: some View {
        SelectCardsView(game: .constant(Game()))
    }
}
