//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 16.01.26.
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    var pegChoices: [Peg] = [.red, .green, .blue, .yellow]
    
    
}

struct Code {
    var kind: Kind
    var pegs: [Peg] = [.green, .blue, .red, .yellow]
    
    enum Kind {
        case master
        case guess
        case attempt
        case unknown
    }
}
