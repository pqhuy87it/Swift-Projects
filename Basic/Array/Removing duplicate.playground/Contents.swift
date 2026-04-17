import UIKit

extension Array where Element: Hashable {
	var uniques: Array {
		var buffer = Array()
		var added = Set<Element>()
		for elem in self {
			if !added.contains(elem) {
				buffer.append(elem)
				added.insert(elem)
			}
		}
		return buffer
	}
}

let vals = [1, 4, 2, 2, 6, 24, 15, 2, 60, 15, 6]
let uniqueVals = vals.uniques // [1, 4, 2, 6, 24, 15, 60]
print(uniqueVals)

func removeDuplicates(from items: [Int]) -> [Int] {
	let uniqueItems = NSOrderedSet(array: items)
	return (uniqueItems.array as? [Int]) ?? []
}

let removeDuplicateArray = removeDuplicates(from: vals)
print(removeDuplicateArray)

