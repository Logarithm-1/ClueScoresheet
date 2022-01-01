//
//  SheetHeaderView.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI
/*
struct SheetHeaderView: View {
    @Binding var game: Game
    
    @State var suspectProgress: CGFloat = 0.67
    @State var weapondProgress: CGFloat = 0.39
    @State var roomProgress: CGFloat = 1
    
    var body: some View {
        HStack {
            GuiltyImage(game: $game, type: .Suspect)
            GuiltyImage(game: $game, type: .Weapond)
            GuiltyImage(game: $game, type: .Room)
        }.padding(5)
    }
}

struct GuiltyImage: View {
    @Binding var game: Game
    @State var type: CardType
    
    var body: some View {
        if(type == .Suspect) {
            ZStack {
                CirclarProgrossBar(progress: 1).stroke(Color.midnightBlue, lineWidth: 5)
                CirclarProgrossBar(progress: CGFloat(game.guiltySuspect.probability)).stroke((game.guiltySuspect.probability == 1) ? Color.green : Color.blue, lineWidth: 5)
                Group {
                    Image(game.guiltySuspect.suspect.imageName).resizable().aspectRatio(1, contentMode: .fit).clipShape(Circle())
                }.padding(5)
            }
        } else if(type == .Weapond) {
            ZStack {
                CirclarProgrossBar(progress: 1).stroke(Color.midnightBlue, lineWidth: 5)
                CirclarProgrossBar(progress: CGFloat(game.guiltyWeapond.probability)).stroke((game.guiltyWeapond.probability == 1) ? Color.green : Color.blue, lineWidth: 5)
                Group {
                    Image(game.guiltyWeapond.weapond.imageName).resizable().aspectRatio(1, contentMode: .fit).clipShape(Circle())
                }.padding(5)
            }
        } else if(type == .Room){
            ZStack {
                CirclarProgrossBar(progress: 1).stroke(Color.midnightBlue, lineWidth: 5)
                CirclarProgrossBar(progress: CGFloat(game.guiltyRoom.probability)).stroke((game.guiltyRoom.probability == 1) ? Color.green : Color.blue, lineWidth: 5)
                Group {
                    Image(game.guiltyRoom.room.imageName).resizable().aspectRatio(1, contentMode: .fit).clipShape(Circle())
                }.padding(5)
            }
        } else {
            Text("Please use Suspect, Weapond, or Room")
        }
    }
}

struct CirclarProgrossBar: Shape {
    @State var progress: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        if(progress == 1) {
            path.addEllipse(in: CGRect(x: (rect.midX - min(rect.width, rect.height)/2), y: rect.minY, width: min(rect.width, rect.height), height: min(rect.width, rect.height)))
        } else {
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: min(rect.width, rect.height)/2.0, startAngle: .degrees(270), endAngle: .degrees(360*progress - 90), clockwise: false)
        }

        return path
    }
}

struct SheetHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderView(game: .constant(Game())).frame(height: 60)
    }
}
*/
