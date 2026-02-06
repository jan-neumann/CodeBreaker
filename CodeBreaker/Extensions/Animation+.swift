//
//  Animation+.swift
//  CodeBreaker
//
//  Created by Jan Neumann on 03.02.26.
//

import SwiftUI

extension Animation {
    static let restart = Animation.spring(.bouncy, blendDuration: 0.5)
    static let guess = Animation.easeInOut(duration: 0.5)
    static let selection = Animation.easeInOut(duration: 0.5)
}
