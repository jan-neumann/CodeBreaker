//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 14.01.26.
//

import SwiftUI

struct GameView<T: Hashable>: View {
    
    let pegChoices: [Peg<T>]
    let missing: Peg<T>
    @State var game: CodeBreaker<T>?
    
    func resetGame() {
        game = CodeBreaker<T>(
            pegChoices: pegChoices,
            missing: missing,
            count: Int.random(in: 3...6)
        )
    }
    
    var body: some View {
        VStack {
            if let game = game {
                view(for: game.masterCode)
                view(for: game.guess)
                
                ScrollView {
                    Divider()
                    ForEach(game.attempts.indices.reversed(),
                            id: \.self) { index in
                        view(for: game.attempts[index])
                    }
                }
            }
            pegChooser
        }
        .padding()
        .onAppear {
            resetGame()
        }
        
    }
    
    var pegChooser: some View {
        return EmptyView()
    }
    
    var guessButton: some View {
        Button("Guess") {
            guard game != nil else { return }
            withAnimation {
                game!.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code<T>) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index], missing: missing)
                    .onTapGesture {
                        if code.kind == .guess, game != nil {
                            game!.changeGuessPeg(at: index)
                        }
                    }
            }
            Rectangle()
                .foregroundStyle(.clear)
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkers(matches: matches)
                    } else if code.kind == .guess {
                        guessButton
                        
                    }
                }
            
        }
    }
}

#Preview {
    GameView<String>(pegChoices: [.init("🐱"), .init("🐹"), .init("🐯"), .init("🐸")], missing: .init(" "))
}
