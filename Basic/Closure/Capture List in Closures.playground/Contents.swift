import UIKit

var c = 0
var d = 0

let smartClosure: () -> () = {
    print(c, d)
}

//let smartClosure: () -> () = { [c, d] in
//    print(c, d)
//}

smartClosure()

c = 4
d = 5

smartClosure()
