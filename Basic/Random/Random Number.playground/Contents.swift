import UIKit
import GameKit

let randomInt = Int.random(in: 0..<6)
print(randomInt
)
let randomDouble = Double.random(in: 2.71828...3.14159)
print(randomDouble)

let randomBool = Bool.random()
print(randomBool)

// Generates integers starting with 0 up to, and including, 10
let randomIntNumber = Int.random(in: 0 ... 10)
print(randomIntNumber)

let numbers: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

private func randomNumberGenerator() -> Int {
	let random = GKRandomSource.sharedRandom().nextInt(upperBound: numbers.count)
	return numbers[random]
}

let number = randomNumberGenerator()
print(number)
