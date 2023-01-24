//
//  Array+ext.swift
//  Weder
//
//  Created by Daniel Rostami on 15/8/2022.
//

import Foundation

extension Array where Element: Hashable {
    var mode: Element? {
        return reduce([Element: Int]()) {
            var counts = $0
            counts[$1] = ($0[$1] ?? 0) + 1
            return counts
        }.max { $0.1 < $1.1 }?.0
    }
}

extension Array where Element == Double {
    var average: Double {
        let sum = reduce(0, +)
        let average = Double(sum) / Double(count)
        return average
    }
}

extension Array where Element == Int {
    var average: Int {
        let sum = reduce(0, +)
        let average = Int(sum) / Int(count)
        return average
    }
}
