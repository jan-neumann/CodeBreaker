//
//  Animation+.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 03.02.26.
//

import SwiftUI

extension Animation {
    static let codeBreaker = Animation.easeInOut(duration: 3)
    static let restart = codeBreaker
    static let guess = codeBreaker
}
