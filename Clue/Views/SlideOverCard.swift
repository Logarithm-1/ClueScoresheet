//
//  SlideOverCard.swift
//  Clue
//
//  Created by Logan Richards on 12/27/21.
//

import SwiftUI

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

enum CardPosition: CGFloat {
    case top = 100
    case middle = 500
    case bottom = 750
}

struct SlideOverCard<Content: View>: View {
    @GestureState private var dragState = DragState.inactive
    @State var position = CardPosition.middle
    
    var content: () -> Content
    
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
            }
            .onEnded(onDragEnded)
        
        return Group {
            Handle()
            self.content()
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .shadow, radius: 10)
        .offset(y: self.position.rawValue + self.dragState.translation.height)
        .animation(.interpolatingSpring(stiffness: 300, damping: 30, initialVelocity: 10), value: dragState.isDragging)
        .gesture(drag)
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
        let cardTopEdgeLocation = self.position.rawValue + drag.translation.height
        let positionAbove: CardPosition
        let positionBelow: CardPosition
        let closestPosition: CardPosition
        
        if(cardTopEdgeLocation <= CardPosition.middle.rawValue) {
            positionAbove = .top
            positionBelow = .middle
        } else {
            positionAbove = .middle
            positionBelow = .bottom
        }
        
        if((cardTopEdgeLocation - positionAbove.rawValue) < (positionBelow.rawValue - cardTopEdgeLocation)) {
            closestPosition = positionAbove
        } else {
            closestPosition = positionBelow
        }
        
        if(verticalDirection > 0) {
            self.position = positionBelow
        } else if(verticalDirection < 0) {
            self.position = positionAbove
        } else {
            self.position = closestPosition
        }
    }
}

struct SlideOverCard_Previews: PreviewProvider {
    static var previews: some View {
        SlideOverCard {
            VStack {
                Text("Hello")
            }
        }
    }
}
