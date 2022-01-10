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

enum CardPosition {
    case top, middle, bottom
    
    func offsetFromTop() -> CGFloat {
        switch self {
        case .bottom:
            return UIScreen.main.bounds.height - 100
        case .middle:
            return UIScreen.main.bounds.height/2
        case .top:
            return 80
        }
    }
}

struct SlideOverCard<Backgroud: View, Content: View, Header: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @GestureState private var dragState = DragState.inactive
    @State var position = CardPosition.middle
    @State var offset: CGSize = CGSize.zero
    
    var animation: Animation {
        Animation.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)
    }
    
    var background: () -> Backgroud
    var content: () -> Content
    var header: () -> Header
    
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
            }
            .onChanged { _ in
                offset = .zero
            }
            .onEnded(onDragEnded)
        
        return GeometryReader { geometry in
            ZStack(alignment: .top) {
                self.background()
                
                VStack(alignment: .center) {
                    Handle()
                    self.header()
                        .frame(height: 60)
                        .padding(.bottom, position == .bottom ? 20 : 10)
                    Divider()
                    self.content()
                    Spacer().frame(height: getYOffset(from: geometry.frame(in: .global)))
                }
                .background(Material.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(color: .shadow, radius: 10)
                .offset(y: getYOffset(from: geometry.frame(in: .global)))
                .animation(animation, value: dragState.isDragging)
                .gesture(drag)
            }
        }
    }
    
    private func getYOffset(from frame: CGRect) -> CGFloat {
        var offset = position.offsetFromTop()
        offset -= frame.minY //Subtracting the top position of parent view such that it should always stay the same bottom position relative to the screen
        return max(0, offset + self.dragState.translation.height) //Offset should be between 0 and the screen height, such that it will aways be on the fram
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        // Determining the direction of the drag gesture and its distance from the top
        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
        let offsetFromTopView = position.offsetFromTop() + drag.translation.height
        
        // Setting stops
        let positionAbove: CardPosition
        let positionBelow: CardPosition
        
        // Nearest position for card to snap to.
        let closestPosition: CardPosition
        
        // Determining wheather card is above or below
        if(offsetFromTopView <= CardPosition.middle.offsetFromTop()) {
            positionAbove = .top
            positionBelow = .middle
        } else {
            positionAbove = .middle
            positionBelow = .bottom
        }
        
        // Determining wheather card is closest to top or bottom
        if((offsetFromTopView - positionAbove.offsetFromTop()) < (positionBelow.offsetFromTop() - offsetFromTopView)) {
            closestPosition = positionAbove
        } else {
            closestPosition = positionBelow
        }
        
        // Determining the card's position.
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
            Text("Background")
        } content: {
            Text("Card")
        } header: {
            Text("Header")
        }
    }
}
