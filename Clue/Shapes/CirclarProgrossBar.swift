//
//  CirclarProgrossBar.swift
//  Clue
//
//  Created by Logan Richards on 1/1/22.
//

import SwiftUI

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

struct CirclarProgrossBar_Previews: PreviewProvider {
    static var previews: some View {
        CirclarProgrossBar(progress: 0.32)
    }
}
