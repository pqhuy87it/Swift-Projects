import Foundation

// Structs

struct Dog {
    var name = ""
    var age = 0
    var furColor = ""
    
    func bark() {
        print("Woof! My name is \(name) and I am \(age) years old")
    }
}

var myDog = Dog()
myDog.age = 2

// Make a struct of something in your room

struct HeadPhone {
    var color : String
    var brand : String
}
