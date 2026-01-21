//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 21.01.26.
//

import SwiftUI

struct CodeBreakerView: View {
    
    @State private var emojiView: Bool = false
    @State private var restartGame: Bool = false
    
    var body: some View {
        
        if !restartGame {
            VStack {
                if emojiView {
                    GameView<String>(
                        pegChoices: [.init("🐱"), .init("🐹"), .init("🐯"), .init("🐸")],
                        missing: .init(""),
                    )
                } else {
                    GameView<Color>(
                        pegChoices: [.init(.blue), .init(.red), .init(.yellow), .init(.green)],
                        missing: .init(.clear)
                    )
                }
                
                restartButton
            }
        } else {
            ProgressView()
                .scaleEffect(3)
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            restartGame = true
            emojiView = Bool.random()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    restartGame = false
                }
            }
        }
        .font(.largeTitle)
    }
}

#Preview {
    CodeBreakerView()
}
