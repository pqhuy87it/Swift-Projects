import Foundation

// Classes

class Dog {
    var name = ""
    var age = 0
    var furColor = ""
    
    func bark() {
        print("Woof! My name is \(name) and I am \(age) years old")
    }
}

var myDog = Dog()
myDog.age = 8
myDog.name = "Fido"
myDog.furColor = "Brown"

myDog.bark()

var dog2 = Dog()
dog2.age = 3
dog2.name = "Jane"
dog2.furColor = "White"

dog2.bark()

// Make a class based off something in the room around you

class WaterBottle {
    var volume = 0.0
    var color = ""
}

var myNalgene = WaterBottle()
myNalgene.volume = 500.0
myNalgene.color = "Purple"
