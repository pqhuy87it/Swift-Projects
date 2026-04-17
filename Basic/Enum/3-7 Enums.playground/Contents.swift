import Foundation

// Enums

enum Compass {
    case north
    case south
    case east
    case west
}

var direction : Compass = .east

func getDirections(whichWay : Compass) {
    if whichWay == .east {
        print("Turn right")
    }
}


getDirections(whichWay: .east)















enum FurColor {
    case Black
    case Brown
    case White
    case Golden
}

struct Dog {
    var age : Int
    var name : String
    var furColor : FurColor
}

Dog(age: 8, name: "Fido", furColor: .Golden)

// Add enum to a previous class or struct
