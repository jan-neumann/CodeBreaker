//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 14.01.26.
//

import SwiftUI

struct CodeView<T: Hashable>: View {
    
    // MARK: - Data In
    let pegChoices: [Peg<T>]
    let missing: Peg<T>
    
    // MARK: - Data owned by View
    @State private var game: CodeBreaker<T> = CodeBreaker<T>()
    @State private var selection: Int = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            
                view(for: game.masterCode)
                view(for: game.guess)
                
                ScrollView {
                    Divider()
                    ForEach(game.attempts.indices.reversed(),
                            id: \.self) { index in
                        view(for: game.attempts[index])
                    }
                }
            
            PegChooser(game: $game, missing: missing, selection: $selection)
        }
        .padding()
        .onAppear {
            resetGame()
        }
    }
    
    
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    func view(for code: Code<T>) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index], missing: missing)
                    .padding(Selection.border)
                    .background(
                        selectionBackground(index: index, codeKind: code.kind)
                    )
                    .onTapGesture {
                        if code.kind == .guess {
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
            Selection.shape
                .foregroundStyle(Selection.color)
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

private struct GuessButton {
    static let minimumFontSize: CGFloat = 8
    static let maximumFontSize: CGFloat = 80
    static let scaleFactor = minimumFontSize / maximumFontSize
}

private struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = .gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    CodeView<String>(pegChoices: [.init("🐱"), .init("🐹"), .init("🐯"), .init("🐸")], missing: .init(" "))
}
