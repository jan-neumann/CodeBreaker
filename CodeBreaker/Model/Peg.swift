//
//  Peg.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 23.01.26.
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