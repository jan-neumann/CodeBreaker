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
        }
        .padding()
        .onAppear {
            resetGame()
        }
        
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
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(foregroundColor(for: code.pegs[index].value))
                    .overlay(overlayText(for: code.pegs[index].value))
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.1)
                    .onTapGesture {
                        if code.kind == .guess, game != nil {
                            game!.changeGuessPeg(at: index)
                        }
                    }
            }
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
    
    func overlayText(for value: T) -> some View {
       Text(value as? String ?? "")
    }
    
    func foregroundColor(for value: T) -> Color {
        value as? Color ?? Color.clear
    }
    
}

#Preview {
    GameView<String>(pegChoices: [.init("🐱"), .init("🐹"), .init("🐯"), .init("🐸")], missing: .init(" "))
}
