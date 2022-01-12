//
//  Collection+Extension.swift
//  Swift-Extension
//
//  Created by Pham Quang Huy on 2020/05/17.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import Foundation
import UIKit

// https://stackoverflow.com/questions/26395766/swift-what-is-the-right-way-to-split-up-a-string-resulting-in-a-string-wi/38156873#38156873

extension Collection where Index == Int {
    func chunked(by chunkSize: Int) -> [[Element]] {
        stride(from: startIndex, to: endIndex, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, count)])
        }
    }
}


// https://stackoverflow.com/questions/64932656/elegant-way-to-split-an-array-in-swift

/*
 [0, 1, 2, 3, 4, 5, 6].splitIn(subSequences: 3)   // [[0, 3, 6], [1, 4], [2, 5]]
 [0, 1, 2].splitIn(subSequences: 4)               // [[0], [1], [2], []]
 "0123456".splitIn(subSequences: 3)               // ["036", "14", "25"]
 */

extension RangeReplaceableCollection {
    func every(n: Int, start: Int = 0) -> UnfoldSequence<Element,Index> {
            sequence(state: dropFirst(start).startIndex) { index in
                guard index < endIndex else { return nil }
                defer { index = self.index(index, offsetBy: n, limitedBy: endIndex) ?? endIndex }
                return self[index]
            }
        }
    
    func splitIn(subSequences n: Int) -> [SubSequence] {
        (0..<n).map { .init(every(n: n, start: $0)) }
    }
}

public extension Collection {
    /// SwifterSwift: The full range of the collection.
    var fullRange: Range<Index> { startIndex..<endIndex }
    
    /// SwifterSwift: Safe protects the array from out of bounds by use of optional.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safe: 1] -> 2
    ///        arr[safe: 10] -> nil
    ///
    /// - Parameter index: index of element to access element.
    
    /*
     let array = [0, 1, 2]
     if let item = array[safe: 5] {
         print(item)
     } else {
         print("unreachable")
     }
     */
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// SwifterSwift: Returns an array of slices of length "size" from the array. If array can't be split evenly, the final slice will be the remaining elements.
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: The size of the slices to be returned.
    /// - Returns: grouped self.
    func group(by size: Int) -> [[Element]]? {
        // Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var start = startIndex
        var slices = [[Element]]()
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            slices.append(Array(self[start..<end]))
            start = end
        }
        return slices
    }
    
    /// SwifterSwift: Get all indices where condition is met.
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].indices(where: { $0 == 1 }) -> [0, 2, 5]
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: all indices where the specified condition evaluates to true (optional).
    func indices(where condition: (Element) throws -> Bool) rethrows -> [Index]? {
        let indices = try self.indices.filter { try condition(self[$0]) }
        return indices.isEmpty ? nil : indices
    }
    
    /// SwifterSwift: Calls the given closure with an array of size of the parameter slice.
    ///
    ///     [0, 2, 4, 7].forEach(slice: 2) { print($0) } -> // print: [0, 2], [4, 7]
    ///     [0, 2, 4, 7, 6].forEach(slice: 2) { print($0) } -> // print: [0, 2], [4, 7], [6]
    ///
    /// - Parameters:
    ///   - slice: size of array in each interation.
    ///   - body: a closure that takes an array of slice size as a parameter.
    func forEach(slice: Int, body: ([Element]) throws -> Void) rethrows {
        var start = startIndex
        while case let end = index(start, offsetBy: slice, limitedBy: endIndex) ?? endIndex,
            start != end {
            try body(Array(self[start..<end]))
            start = end
        }
    }
}

// MARK: - Methods (Equatable)

public extension Collection where Element: Equatable {
    /// SwifterSwift: All indices of specified item.
    ///
    ///        [1, 2, 2, 3, 4, 2, 5].indices(of 2) -> [1, 2, 5]
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].indices(of 2.3) -> [1]
    ///        ["h", "e", "l", "l", "o"].indices(of "l") -> [2, 3]
    ///
    /// - Parameter item: item to check.
    /// - Returns: an array with all indices of the given item.
    func indices(of item: Element) -> [Index] {
        return indices.filter { self[$0] == item }
    }
}

// MARK: - Methods (BinaryInteger)

public extension Collection where Element: BinaryInteger {
    /// SwifterSwift: Average of all elements in array.
    ///
    /// - Returns: the average of the array's elements.
    func average() -> Double {
        // http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
        guard !isEmpty else { return .zero }
        return Double(reduce(.zero, +)) / Double(count)
    }
}

// MARK: - Methods (FloatingPoint)

public extension Collection where Element: FloatingPoint {
    /// SwifterSwift: Average of all elements in array.
    ///
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: average of the array's elements.
    func average() -> Element {
        guard !isEmpty else { return .zero }
        return reduce(.zero, +) / Element(count)
    }
}
