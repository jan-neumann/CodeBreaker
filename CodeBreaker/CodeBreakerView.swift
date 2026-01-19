//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 14.01.26.
//

import SwiftUI

struct CodeBreakerView: View {
    

    @State var game = CodeBreaker(
        pegChoices: [.red, .green, .blue, .yellow])
    
    var body: some View {
        
        VStack {
            view(for: game.masterCode)
            view(for: game.guess)
            
            ScrollView {
               
                Divider()
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
           
            restartButton
        }
        .padding()
        
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                game = CodeBreaker(pegChoices: [.red, .green, .blue, .yellow])
            }
        }
        .font(.largeTitle)
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
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
}


#Preview {
    CodeBreakerView()
}
