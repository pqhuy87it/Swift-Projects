import UIKit

let numbers = [[1,2,3],[4],[5,6,7,8,9]]

// reduce
let reduced = numbers.reduce([], +)
print(reduced)

// flatMap
let flattened = numbers.flatMap { $0 }
print(flattened)

// joined
let joined = Array(numbers.joined())
print(joined)
