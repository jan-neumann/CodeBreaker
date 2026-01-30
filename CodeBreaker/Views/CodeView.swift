//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 30.01.26.
//

import SwiftUI

struct CodeView<T: Hashable, AncillaryView: View>: View {
    
    // MARK: - Data In
    let code: Code<T>
    var selection: Int? = nil
    @ViewBuilder let ancillaryView: () -> AncillaryView
    var onSelect: ((Int) -> Void)? = nil
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                if let missing = code.missing {
                    PegView(peg: code.pegs[index], missing: missing)
                        .padding(Selection.border)
                        .background(
                            selectionBackground(index: index, codeKind: code.kind)
                        )
                        .overlay {
                            Selection.shape
                                .foregroundStyle(code.isHidden ? .gray : .clear)
                        }
                        .onTapGesture {
                            onSelect?(index)
                        }
                }
            }
            Rectangle()
                .foregroundStyle(.clear)
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    ancillaryView()
                }
            
        }
    }
    
    @ViewBuilder
    func selectionBackground(index: Int, codeKind: Code<T>.Kind) -> some View {
        if let selection = selection, selection == index, codeKind == .guess {
            Selection.shape
                .foregroundStyle(Selection.color)
        } else {
            EmptyView()
        }
    }
    
}

fileprivate struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = .gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}

