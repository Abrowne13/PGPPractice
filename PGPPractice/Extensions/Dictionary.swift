//
//  Dictionary.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation

extension Dictionary where Value: Equatable {
    func key(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
