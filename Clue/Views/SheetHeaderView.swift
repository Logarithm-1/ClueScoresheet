//
//  SheetHeaderView.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct SheetHeaderView: View {
    @Binding var game: Game
    
    @State var suspectProgress: CGFloat = 0.67
    @State var weapondProgress: CGFloat = 0.39
    @State var roomProgress: CGFloat = 1
    
    var body: some View {
        HStack {
            ZStack {
                CirclarProgrossBar(progress: .constant(1)).stroke(Color.midnightBlue, lineWidth: 5)
                CirclarProgrossBar(progress: $suspectProgress).stroke((suspectProgress == 1) ? Color.green : Color.blue, lineWidth: 5)
                Group {
                    Image("missScarlet").resizable().aspectRatio(1, contentMode: .fit).clipShape(Circle())
                }.padding(5)
            }
            
            ZStack {
                CirclarProgrossBar(progress: .constant(1)).stroke(Color.midnightBlue, lineWidth: 5)
                CirclarProgrossBar(progress: $weapondProgress).stroke((weapondProgress == 1) ? Color.green : Color.blue, lineWidth: 5)
                
                Group {
                    Image("candleStick").resizable().aspectRatio(1, contentMode: .fit).clipShape(Circle())
                }.padding(5)
            }
            
            ZStack {
                CirclarProgrossBar(progress: .constant(1)).stroke(Color.midnightBlue, lineWidth: 5)
                CirclarProgrossBar(progress: $roomProgress).stroke((roomProgress == 1) ? Color.green : Color.blue, lineWidth: 5)
                
                Group {
                    Image("conservatory").resizable().aspectRatio(1, contentMode: .fit).clipShape(Circle())
                }.padding(5)
            }
        }.padding(5)
    }
}

struct CirclarProgrossBar: Shape {
    @Binding var progress: CGFloat
    
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
