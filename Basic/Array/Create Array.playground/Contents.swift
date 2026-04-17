import UIKit

var str = "Hello, playground"

// create array

let min = 0
let max = 10

// create array int
let intArray = [Int](min...max)
print(intArray)

let intArray1 = (min...max).map{$0}
print(intArray1)

let stringArray = (min..<max).map{_ in "*"}
print(stringArray)

// sort array

let array = [1,9,8,7,6,2,3,0,5,4]

let ascendingSortedArray = array.sorted { (number1, number2) -> Bool in
    return number1 < number2
}

print(ascendingSortedArray)

let descendingSortedArray = array.sorted { (numer1, number2) -> Bool in
    return numer1 > number2
}

print(descendingSortedArray)
