//
//  Handle.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

struct Handle: View {
    private let handleThickness: CGFloat = 5
    
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(.secondary)
            .padding(5)
    }
}

struct Handle_Previews: PreviewProvider {
    static var previews: some View {
        Handle()
    }
}
