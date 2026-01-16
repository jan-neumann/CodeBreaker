//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 14.01.26.
//

import SwiftUI

struct CodeBreakerView: View {
    
    @State var game = CodeBreaker()
    
    var body: some View {
        
        VStack {
            view(for: game.masterCode)
            
            ScrollView {
                view(for: game.guess)
                Divider()
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            Button("Guess") {
                withAnimation {
                    game.attemptGuess()
                }
            }
          
        }
        .padding()
        
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }
            MatchMarkers(matches: code.match(against: game.masterCode))
        }
    }
}


#Preview {
    CodeBreakerView()
}
