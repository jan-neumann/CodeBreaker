//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 14.01.26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            pegs([.green, .blue, .yellow, .red])
            pegs([.green, .red, .yellow, .red])
            pegs([.green, .blue, .blue, .red])
        }
        .padding()
        
    }
    
    func pegs(_ colors: Array<Color>) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
        }
    }
}


#Preview {
    ContentView()
}
