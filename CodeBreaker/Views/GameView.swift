//
//  GameView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 14.01.26.
//

import SwiftUI

struct GameView<T: Hashable>: View {
    
    // MARK: - Data In
    let pegChoices: [Peg<T>]
    let missing: Peg<T>
    
    // MARK: - Data owned by View
    @State private var game: CodeBreaker<T> = CodeBreaker<T>()
    @State private var selection: Int = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            CodeView(code: game.masterCode) { Text("1:04").font(.title) }
            
            if (!game.isOver) {
                CodeView(code: game.guess, selection: selection,
                         ancillaryView: guessButton)  { index in
                    selection = index
                }
            }
            
            ScrollView {
                Divider()
                ForEach(game.attempts.indices.reversed(),
                        id: \.self) { index in
                    CodeView(code: game.attempts[index]) {
                        if let matches = game.attempts[index].matches {
                            MatchMarkers(matches: matches)
                        }
                    }
                }
            }
            
            PegChooser(choices: pegChoices, missing: missing) { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.masterCode.pegs.count
            }
        }
        .padding()
        .onAppear {
            resetGame()
        }
    }
    
    func guessButton() -> some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    func resetGame() {
        game = CodeBreaker<T>(
            pegChoices: pegChoices,
            missing: missing,
            count: Int.random(in: 3...6)
        )
    }
    
}

private struct GuessButton {
    static let minimumFontSize: CGFloat = 8
    static let maximumFontSize: CGFloat = 80
    static let scaleFactor = minimumFontSize / maximumFontSize
}


extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    GameView<String>(pegChoices: [.init("🐱"), .init("🐹"), .init("🐯"), .init("🐸")], missing: .init(" "))
}
