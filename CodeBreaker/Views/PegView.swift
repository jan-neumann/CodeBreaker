//
//  PegView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 23.01.26.
//

import SwiftUI

struct PegView<T: Hashable> : View {
    
    // MARK: - Data In
    let peg: Peg<T>
    let missing: Peg<T>
    
    // MARK: - Body
    let pegShape = Circle() //RoundedRectangle(cornerRadius: 10)
    
    var body: some View {
        pegShape
            .contentShape(pegShape)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(foregroundColor(for: peg.value))
            .overlay(overlayText(for: peg.value))
            .font(.system(size: 80))
            .minimumScaleFactor(0.1)
    }
    
    func overlayText(for value: T) -> some View {
       Text(value as? String ?? "")
    }
    
    func foregroundColor(for value: T) -> Color {
        value as? Color ?? Color.clear
    }
}

#Preview {
    VStack {
        PegView<Color>(peg: .init(.red), missing: .init(.clear))
        PegView<String>(peg: .init("🦁"), missing: .init(""))
    }
    .padding()
}
