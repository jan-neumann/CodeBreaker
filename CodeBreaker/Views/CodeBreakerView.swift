//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 21.01.26.
//

import SwiftUI

struct CodeBreakerView: View {
    
    // MARK: - Constants
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
        .init(.brown),
        .init(.purple),
        .init(.black)
    ]
    let colorMissing: Peg<Color> = .init(.clear)
    
    // MARK: - Data Owned by View
    @State private var emojiView: Bool = false
    
    // MARK: - Body
    var body: some View {

        VStack {
            restartButton
            
            Group {
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
            }
        
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            emojiView.toggle()
        }
        
        
    }
}


#Preview {
    CodeBreakerView()
}
