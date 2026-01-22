//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 21.01.26.
//

import SwiftUI

struct CodeBreakerView: View {
    
    let emojiPegs: [Peg<String>] = [
        .init("🐱"),
        .init("🐹"),
        .init("🐯"),
        .init("🐸"),
        .init("🐻‍❄️"),
        .init("🦁")
    ]
    let emojiMissing: Peg<String> = .init("")
    
    let colorPegs: [Peg<Color>] = [
        .init(Color.blue),
        .init(.red),
        .init(.yellow),
        .init(.green),
        .init(.pink),
        .init(.purple)
    ]
    let colorMissing: Peg<Color> = .init(.clear)
    
    @State private var emojiView: Bool = false
    @State private var restartGame: Bool = false
    
    
    var body: some View {
        
        if !restartGame {
            VStack {
                if emojiView {
                    GameView<String>(
                        pegChoices: emojiPegs,
                        missing: emojiMissing,
                    )
                } else {
                    GameView<Color>(
                        pegChoices: colorPegs,
                        missing: colorMissing
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
