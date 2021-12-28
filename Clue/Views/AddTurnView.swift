//
//  AddTurnView.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct AddTurnView: View {
    @Binding var game: Game
    
    @State var player: Int = -1
    @State var asking: Int = -1
    @State var suspectID: UUID?
    @State var weapondID: UUID?
    @State var roomID: UUID?
    @State var gaveAny: Bool = false
    
    @State var cardGave: CardType = .None
    
    var body: some View {
        HStack {
            Text("Current Player:").bold()
            SelectPlayerView(game: $game, player: $player)
        }
        
        HStack {
            Text("Asking:").bold()
            SelectPlayerView(game: $game, player: $asking)
        }
        
        HStack {
            Text("Suspect:").bold()
            SelectSuspectView(game: $game, id: $suspectID)
        }
        
        HStack {
            Text("Weapond:").bold()
            SelectWeapondView(game: $game, id: $weapondID)
        }
        
        HStack {
            Text("Room:").bold()
            SelectRoomView(game: $game, id: $roomID)
        }
        
        //If current player is the user
        if(player == game.user) {
            HStack {
                Text("Card Gave:").bold()
                SelectCardGaveView(game: $game, card: $cardGave, suspectID: $suspectID, weapondID: $weapondID, roomID: $roomID)
            }
        } else {
            HStack {
                Toggle("Asking Gave Any Cards", isOn: $gaveAny)
            }
        }
        
        Button(action: {
            if(player != game.user) {
                if(gaveAny) {
                    cardGave = .Unknown
                } else {
                    cardGave = .None
                }
            }
            
            if(game.addTurn(player: player, asking: asking, suspectID: suspectID, weapondID: weapondID, roomID: roomID, cardGave: cardGave)) {
                //Susecffully added turn
            } else {
                //Promt
                print("Invalid Turn Parameters")
            }
        }) {
            Text("Add")
        }
    }
}

struct SelectSuspectView: View {
    @Binding var game: Game
    @Binding var id: UUID?
    var placeholder = "Suspect"
    
    var body: some View {
        Menu {
            ForEach(game.suspects) { suspect in
                Button(suspect.name) {
                    self.id = suspect.id
                }
            }
        } label: {
            HStack {
                Text(game.getSuspectName(uuid: id).isEmpty ? placeholder : game.getSuspectName(uuid: id))
                    .foregroundColor(id == nil ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.blue)
                    .font(Font.system(size: 20, weight: .bold))
            }
        }
    }
}

struct SelectWeapondView: View {
    @Binding var game: Game
    @Binding var id: UUID?
    var placeholder = "Weopond"
    
    var body: some View {
        Menu {
            ForEach(game.weaponds) { weapond in
                Button(weapond.name) {
                    self.id = weapond.id
                }
            }
        } label: {
            HStack {
                Text(game.getWeapondName(uuid: id).isEmpty ? placeholder : game.getWeapondName(uuid: id))
                    .foregroundColor(id == nil ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.blue)
                    .font(Font.system(size: 20, weight: .bold))
            }
        }
    }
}

struct SelectRoomView: View {
    @Binding var game: Game
    @Binding var id: UUID?
    var placeholder = "Room"
    
    var body: some View {
        Menu {
            ForEach(game.rooms) { room in
                Button(room.name) {
                    self.id = room.id
                }
            }
        } label: {
            HStack {
                Text(game.getRoomName(uuid: id).isEmpty ? placeholder : game.getRoomName(uuid: id))
                    .foregroundColor(id == nil ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.blue)
                    .font(Font.system(size: 20, weight: .bold))
            }
        }
    }
}

struct SelectPlayerView: View {
    @Binding var game: Game
    @Binding var player: Int
    var placeholder = "Player"
    
    var body: some View {
        Menu {
            ForEach(0..<game.numberOfPlayers) { player in
                Button(game.playerNames[player]) {
                    self.player = player
                }
            }
        } label: {
            HStack {
                Text(game.validPlayer(player) ? game.playerNames[player] : placeholder)
                    .foregroundColor(game.validPlayer(player) ? .primary : .secondary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.blue)
                    .font(Font.system(size: 20, weight: .bold))
            }
        }
    }
}

struct SelectCardGaveView: View {
    @Binding var game: Game
    @Binding var card: CardType
    @Binding var suspectID: UUID?
    @Binding var weapondID: UUID?
    @Binding var roomID: UUID?
    var placeholder = "Select Card They Gave"
    
    var body: some View {
        Menu {
            Section {
                Button("No Card Given") {
                    self.card = .None
                }
            }
            
            if(game.getSuspectName(uuid: suspectID) != "") {
                Button(game.getSuspectName(uuid: suspectID)) {
                    self.card = .Suspect
                }
            }
            
            if(game.getWeapondName(uuid: weapondID) != "") {
                Button(game.getWeapondName(uuid: weapondID)) {
                    self.card = .Weapond
                }
            }
            
            if(game.getRoomName(uuid: roomID) != "") {
                Button(game.getRoomName(uuid: roomID)) {
                    self.card = .Room
                }
            }
            
            if(game.getSuspectName(uuid: suspectID) == "" && game.getWeapondName(uuid: weapondID) == "" && game.getRoomName(uuid: roomID) == "") {
                Text("Please select Suspect, Weapond, and Room first")
            }
        } label: {
            HStack {
                if(card == .Suspect) {
                    Text(game.getSuspectName(uuid: suspectID)).foregroundColor(.primary)
                } else if(card == .Weapond) {
                    Text(game.getWeapondName(uuid: weapondID)).foregroundColor(.primary)
                } else if(card == .Room) {
                    Text(game.getRoomName(uuid: roomID)).foregroundColor(.primary)
                } else {
                    Text(placeholder).foregroundColor(.secondary)
                }
                
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.blue)
                    .font(Font.system(size: 20, weight: .bold))
            }
        }
    }
}



struct AddTurnView_Previews: PreviewProvider {
    static var previews: some View {
        AddTurnView(game: .constant(Game()))
    }
}
