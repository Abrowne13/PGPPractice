//
//  ClosedRange.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation

extension ClosedRange where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}
