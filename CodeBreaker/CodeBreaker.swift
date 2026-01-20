//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 16.01.26.
//

import SwiftUI

struct Peg<T: Hashable>: Equatable {
    static func == (lhs: Peg<T>, rhs: Peg<T>) -> Bool {
        lhs.value == rhs.value
    }
    
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}


struct CodeBreaker<T: Hashable> {
    var masterCode: Code<T>
    var guess: Code<T>
    var attempts: [Code<T>] = []
    let pegChoices: [Peg<T>]
    let missing: Peg<T>
    
    init(pegChoices: [Peg<T>] = [.init(Color.red), .init(Color.green), .init(Color.blue), .init(Color.yellow)], missing: Peg<T> = .init(Color.clear), count: Int) {
        self.masterCode = Code(kind: .master, missing: missing, count: count)
        self.guess = Code(kind: .guess, missing: missing, count: count)
        self.pegChoices = pegChoices
        self.masterCode.randomize(from: pegChoices)
        self.missing = missing
        
        print(masterCode)
    }
    
    mutating func attemptGuess() {
        
        // Make sure that all pegs got a color
        guard guess.pegs.firstIndex(of: missing) == nil else {
            return
        }
        // Make sure that attempts which were tried before, are ignored
        guard !attempts.contains(where: { $0.pegs == guess.pegs }) else {
            return
        }
        
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? missing
        }
    }
}


struct Code<T: Hashable> {
    
    
    enum Kind: Equatable {
        case master
        case guess
        case attempt([Match])
        case unknown
    }
    
    var kind: Kind
    var pegs: [Peg<T>]
    var missing: Peg<T>
    
    init(kind: Kind, missing: Peg<T>, count: Int) {
        self.kind = kind
        self.pegs = Array(repeating: missing, count: count)
        self.missing = missing
    }

    mutating func randomize(from pegChoices: [Peg<T>]) {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches):
            return matches
        default:
            return []
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
}

