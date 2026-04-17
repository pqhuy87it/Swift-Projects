import UIKit

var str = "Hello, playground"

enum Foo : CustomStringConvertible {
    case Bing
    case Bang
    case Boom
    
    var description : String {
        switch self {
            // Use Internationalization, as appropriate.
            case .Bing: return "Bing"
            case .Bang: return "Bang"
            case .Boom: return "Boom"
        }
    }
}


