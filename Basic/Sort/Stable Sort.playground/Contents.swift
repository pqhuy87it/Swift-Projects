import UIKit

var str = "Hello, playground"

var array = ["mango", "apple", "pear", "banana", "orange", "apple", "banana"]

enum SortType {
    case Ascending
    case Descending
}

struct SortObject<T> {
    let value:T
    let startPosition:Int
    var sortedPosition:Int?
}

func swiftStableSort<T:Comparable>(array:inout [T], sortType:SortType = .Ascending) {
    
    var sortObjectArray = array.enumerated().map{SortObject<T>(value:$0.element, startPosition:$0.offset, sortedPosition:nil)}
    
    for s in sortObjectArray {
        var offset = 0
        for x in array[0..<s.startPosition]  {
            if s.value < x {
                offset += sortType == .Ascending ? -1 : 0
            }
            else if s.value > x {
                offset += sortType == .Ascending ? 0 : -1
            }
        }
        
        for x in array[s.startPosition+1..<array.endIndex]  {
            if s.value > x  {
                offset += sortType == .Ascending ? 1 : 0
            }
            else if s.value < x  {
                offset += sortType == .Ascending ? 0 : 1
            }
        }
        sortObjectArray[s.startPosition].sortedPosition = offset + s.startPosition
    }
    
    for s in sortObjectArray {
        if let sInd = s.sortedPosition {
            array[sInd] = s.value
        }
    }
    
}

swiftStableSort(array: &array, sortType:.Ascending) // ["apple", "apple", "banana", "banana", "mango", "orange", "pear"]
swiftStableSort(array: &array, sortType:.Descending) // ["pear", "orange", "mango", "banana", "banana", "apple", "apple"]
