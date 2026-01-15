//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 15.01.26.
//

import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}


struct MatchMarkers: View {
    
    var matches: [Match]
    
    var body: some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
            VStack {
                matchMarker(peg: 4)
                matchMarker(peg: 5)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View {
        let exactCount: Int = matches.count(where: { $0 == .exact })
        let foundCount: Int = matches.count(where: { $0 != .nomatch })
        
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    let colors3: [Color] = [.green, .red, .blue]
    let colors4: [Color] = [.red, .green, .blue, .yellow]
    let colors5: [Color] = [.pink, .red, .green, .blue, .yellow]
    let colors6: [Color] = [.red, .green, .blue, .yellow, .pink, .orange]
    
    VStack {
        // 3
        HStack {
            ForEach(colors3.indices, id: \.self) {
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(colors3[$0])
            }
            MatchMarkers(matches: [.exact, .exact, .inexact])
        }
        .padding()
        // 4
        HStack {
            ForEach(colors4.indices, id: \.self) {
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(colors4[$0])
            }
            MatchMarkers(matches: [.exact, .exact, .inexact, .nomatch])
        }
        .padding()
        // 5
        HStack {
            ForEach(colors5.indices, id: \.self) {
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(colors5[$0])
            }
            MatchMarkers(matches: [.exact, .exact, .inexact, .inexact, .inexact])
        }
        .padding()
        // 6
        HStack {
            ForEach(colors6.indices, id: \.self) {
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(colors6[$0])
            }
            MatchMarkers(matches: [.exact, .exact, .inexact, .nomatch, .exact, .inexact])
        }
        .padding()
    }
}
