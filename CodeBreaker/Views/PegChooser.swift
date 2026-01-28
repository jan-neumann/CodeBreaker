//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 27.01.26.
//

import SwiftUI


struct PegChooser<T: Hashable>: View {
    
    @Binding var game: CodeBreaker<T>
    let missing: Peg<T>
    @Binding var selection: Int
    
    @ViewBuilder
    var body: some View {
        HStack {
            ForEach(game.pegChoices) { peg in
                Button {
                    self.game.setGuessPeg(peg, at: selection)
                    selection = (selection + 1) % game.masterCode.pegs.count
                } label: {
                    PegView(peg: peg, missing: missing)
                }
            }
        }
    }
}


