//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 16.01.26.
//

import SwiftUI

struct CodeBreaker<T: Hashable> {
    
    var masterCode: Code<T>
    var guess: Code<T>
    var attempts: [Code<T>] = []
    let pegChoices: [Peg<T>]
    let missingPeg: Peg<T>?
    
    init(pegChoices: [Peg<T>] = [.init(Color.red), .init(Color.green), .init(Color.blue), .init(Color.yellow)], missing: Peg<T> = .init(Color.clear), count: Int) {
        self.masterCode = Code(kind: .master(isHidden: true), missing: missing, count: count)
        self.guess = Code(kind: .guess, missing: missing, count: count)
        self.pegChoices = pegChoices
        self.masterCode.randomize(from: pegChoices)
        self.missingPeg = missing
        print(masterCode)
    }
    
    init() {
        self.masterCode = Code()
        self.guess = Code()
        self.pegChoices = []
        self.missingPeg = nil
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func attemptGuess() {
        guard let missingPeg = missingPeg else {
            return
        }
        // Make sure that all pegs got a color
        guard guess.pegs.firstIndex(of: missingPeg) == nil else {
            return
        }
        // Make sure that attempts which were tried before, are ignored
        guard !attempts.contains(where: { $0.pegs == guess.pegs }) else {
            return
        }
        
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
        guess.reset()
        if isOver {
            masterCode.kind = .master(isHidden: true)
        }
    }
    
    mutating func setGuessPeg(_ peg: Peg<T>, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(at index: Int) {
        guard let missingPeg = missingPeg else { return }
        
        let existingPeg = guess.pegs[index]
        
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? missingPeg
        }
    }
}




