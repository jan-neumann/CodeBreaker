//
//  Code.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 23.01.26.
//


import SwiftUI

struct Code<T: Hashable> {
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempt([Match])
        case unknown
    }
    
    var kind: Kind
    var pegs: [Peg<T>]
    var missing: Peg<T>?
    
    init(kind: Kind, missing: Peg<T>, count: Int) {
        self.kind = kind
        self.pegs = Array(repeating: missing, count: count)
        self.missing = missing
    }
    
    init() {
        self.kind = .unknown
        self.pegs = []
        self.missing = nil
    }

    mutating func randomize(from pegChoices: [Peg<T>]) {
        guard let missing = missing else { return }
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? missing
        }
    }
     
    mutating func reset() {
        guard let missing = missing else { return }
        pegs = Array(repeating: missing, count: pegs.count)
    }
    
    var matches: [Match]? {
        switch kind {
        case .attempt(let matches):
            return matches
        default:
            return nil
        }
    }
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden):
            return isHidden
        default:
            return false
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var pegsToMatch = otherCode.pegs
        let reversedExactMatches = pegs.indices.reversed().map {
            if pegsToMatch.count > $0, pegsToMatch[$0] == pegs[$0] {
                pegsToMatch.remove(at: $0)
                return Match.exact
            } else {
                return .nomatch
            }
        }
        
        let exactMatches = Array(reversedExactMatches.reversed())
        return pegs.indices.map {
            if exactMatches[$0] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[$0]) {
                    pegsToMatch.remove(at: matchIndex)
                    return .inexact
            } else {
                return exactMatches[$0]
            }
        }
    }
    
}
