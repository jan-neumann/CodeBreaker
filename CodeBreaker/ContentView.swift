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
            Circle().foregroundStyle(colors[0])
            Circle().foregroundStyle(colors[1])
            Circle().foregroundStyle(colors[2])
            Circle().foregroundStyle(colors[3])
        }
    }
}

#Preview {
    ContentView()
}
