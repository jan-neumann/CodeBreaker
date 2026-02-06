//
//  UIExtensions.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 06.02.26.
//

import SwiftUI

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

extension AnyTransition {
    static let pegChooser = AnyTransition.offset(x: 0, y: 200)
    static func attempt(_ gameIsOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: gameIsOver ? .opacity : .move(edge: .top),
            removal: .move(edge: .trailing)
        )
    }
}

extension View {
    func flexibleSystemFont(minimum: CGFloat = 8, maximum: CGFloat = 80) -> some View {
        self
            .font(.system(size: maximum))
            .minimumScaleFactor(minimum/maximum)
    }
}
