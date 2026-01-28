//
//  Peg.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 23.01.26.
//


import SwiftUI

struct Peg<T: Hashable>: Equatable, Identifiable {
    
    var id: String
    
    static func == (lhs: Peg<T>, rhs: Peg<T>) -> Bool {
        lhs.value == rhs.value
    }
    
    var value: T
    
    init(_ value: T) {
        self.value = value
        self.id = UUID().uuidString
    }
    
    init(defaultValue: @autoclosure () -> T) {
        self.id = UUID().uuidString
        self.value = defaultValue()
    }
}
