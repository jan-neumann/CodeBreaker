//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 14.01.26.
//

import SwiftUI

struct GameView<T: Hashable>: View {
    
    // MARK: - Data owned by view
    let pegChoices: [Peg<T>]
    let missing: Peg<T>
    @State private var game: CodeBreaker<T>?
    @State private var selection: Int = 0
    
    // MARK: - Body
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
    
    @ViewBuilder
    var pegChooser: some View {
        if let game = game {
            HStack {
                ForEach(game.pegChoices) { peg in
                    Button {
                        self.game!.setGuessPeg(peg, at: selection)
                    } label: {
                        PegView(peg: peg, missing: missing)
                    }
                }
            }
        } else {
            EmptyView()
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
                PegView(peg: code.pegs[index], missing: missing)
                    .padding(5)
                    .background(
                        selectionBackground(index: index, codeKind: code.kind)
                    )
                    .onTapGesture {
                        if code.kind == .guess, game != nil {
                            selection = index
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
    
    @ViewBuilder
    func selectionBackground(index: Int, codeKind: Code<T>.Kind) -> some View {
        if selection == index, codeKind == .guess {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.gray.opacity(0.3))
        } else {
            EmptyView()
        }
    }
    
    func resetGame() {
        game = CodeBreaker<T>(
            pegChoices: pegChoices,
            missing: missing,
            count: Int.random(in: 3...6)
        )
    }
    
}

#Preview {
    GameView<String>(pegChoices: [.init("🐱"), .init("🐹"), .init("🐯"), .init("🐸")], missing: .init(" "))
}
