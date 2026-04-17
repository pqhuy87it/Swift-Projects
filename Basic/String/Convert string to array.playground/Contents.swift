import UIKit

var str = "しょうじょう"
let array = Array(str)
print(array)
let str1 = String(array[0]) + String(array[1])
print(str1)

let array1 = str.map { String($0) }
print(array1)
let str2 = array1[0] + array1[1]
print(str2)
