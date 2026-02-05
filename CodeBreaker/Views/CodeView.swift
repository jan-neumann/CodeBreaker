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
    @Binding var selection: Int
    @ViewBuilder let ancillaryView: () -> AncillaryView
    var onSelect: ((Int) -> Void)? = nil
    
    init(code: Code<T>,
         selection: Binding<Int> = .constant(-1),
         @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() },
         onSelect: ((Int) -> Void)? = nil) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
        self.onSelect = onSelect
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                if let missing = code.missing {
                    PegView(peg: code.pegs[index], missing: missing, isHidden: code.isHidden)
                        .padding(Selection.border)
                        .background( // selection background
                            selectionBackground(index: index, codeKind: code.kind)
                        )
                        .overlay { // hidden code obscuring
                            Selection.shape
                                .foregroundStyle(code.isHidden ? .gray : .clear)
                                .transaction { transaction in
                                    if code.isHidden {
                                        transaction.animation = nil
                                    }
                                }
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
        if selection == index, codeKind == .guess {
            Selection.shape
                .foregroundStyle(Selection.color)
        } else {
            EmptyView()
        }
    }
    
}

struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = .gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}

