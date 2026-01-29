//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 27.01.26.
//

import SwiftUI


struct PegChooser<T: Hashable>: View {
    
    // MARK: - Data In
    let choices: [Peg<T>]
    let missing: Peg<T>
    
    // MARK: - Data Out Function
    let onChoose: (Peg<T>) -> Void
   
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(choices) { peg in
                Button {
                    onChoose(peg)
                } label: {
                    PegView(peg: peg, missing: missing)
                }
            }
        }
    }
    
    
}


