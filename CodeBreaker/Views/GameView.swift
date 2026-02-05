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
    @Binding var restarting: Bool
    
    // MARK: - Data owned by View
    @State private var game: CodeBreaker<T> = CodeBreaker<T>()
    @State private var selection: Int = 0
  
     
    // MARK: - Body
    var body: some View {
        VStack {
            
            if !restarting {
                CodeView(code: game.masterCode) {
                    Text("12:59")
                }
                .animation(nil, value: restarting)
                .transaction { transaction in
                    transaction.animation = nil
                }
            }
            
            if (!game.isOver || restarting) {
                CodeView(code: game.guess, selection: $selection,
                         ancillaryView: guessButton)  { index in
                    selection = index
                }
                .opacity(restarting ? 0 : 1)
                .animation(nil, value: game.attempts.count)
               
            }
            
            ScrollView {
                Divider()
                ForEach(game.attempts.indices.reversed(),
                        id: \.self) { index in
                    CodeView(code: game.attempts[index]) { matchMarkers(index: index)
                    }
                    .transition(.attempt(game.isOver))
                }
                         
            }
            
            if !game.isOver {
                PegChooser(choices: pegChoices,
                           missing: missing,
                           onChoose: changePegAtSelection)
                .transition(.pegChooser)
            }
         
        }
        .padding()
        .onAppear {
            resetGame()
        }
    }
    
    @ViewBuilder
    func matchMarkers(index: Int) -> some View {
        if let matches = game.attempts[index].matches {
            MatchMarkers(matches: matches)
        } else {
            EmptyView()
        }
    }
    
    func guessButton() -> some View {
        Button("Guess") {
            withAnimation(.guess) {
                game.attemptGuess()
                selection = 0
                if game.isOver {
                    game.masterCode.kind = .master(isHidden: false)
                }
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
    
    func changePegAtSelection(to peg: Peg<T>) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.masterCode.pegs.count
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

extension AnyTransition {
    static let pegChooser = AnyTransition.offset(x: 0, y: 200)
    static func attempt(_ gameIsOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: gameIsOver ? .opacity : .move(edge: .top),
            removal: .move(edge: .trailing)
        )
    }
}

#Preview {
    GameView<String>(pegChoices: [.init("🐱"), .init("🐹"), .init("🐯"), .init("🐸")], missing: .init(" "), restarting: .constant(false))
}
