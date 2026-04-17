import Foundation

// Loops

var movies = ["Sandlot","Empror's New Groove","LEGO Movie"]

for number in 1...100 {
    print(number)
}

for x in movies {
    print(x)
}

// Make an array of your favorite numbers. Then print you favorite numbers in order, including what number in the order it is
// Lukcy Numbers 5,7,8
// 1. 5
// 2. 7
// 3. 8

let luckyNumbers = [5,52,236,2,36,23,]

for x in 0..<luckyNumbers.count {
    print("\(x+1). \(luckyNumbers[x])")
}

