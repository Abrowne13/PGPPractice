//
//  CaseIterable.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 8/25/26.
//

import Foundation

public extension CaseIterable where Self: Equatable {
    
    func caseIndex() -> Self.AllCases.Index {
        return Self.allCases.firstIndex(of: self)!
    }
}
