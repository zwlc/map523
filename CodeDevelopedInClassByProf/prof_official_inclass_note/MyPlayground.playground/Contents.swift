import UIKit


//Inheritence
public class CreditCard {
    var number: String
    var name: String
    var balance: Float
    init(aNumber: String, aName: String) {
        self.name = aName
        self.number = aNumber
        self.balance = 0.0
    }
    
    func getBalance() -> Float
    {
        return self.balance
    }
    
    func setBalance(aBalance: Float)
    {
        self.balance = aBalance
    }
    
}

public class RewardCard : CreditCard
{
    var points: Int

    init(aPoint: Int)
    {
        self.points = aPoint
        super.init(aNumber: "Alex", aName: "Johnston")
    }
    
    func test() {
        super.balance = 12
    }
    
    //Example of overriding a method
    override func getBalance() -> Float {
        return self.balance + 100.0
    }
}


//Protocols
//https://docs.swift.org/swift-book/LanguageGuide/Protocols.html
protocol SpaceCraft {
    var fuel_level: Int { get set }
    var model: String { get }
    var elevation: Float { get set }
    
    mutating func setFuel(_: Int)
}

class MarsRover : SpaceCraft {
    var fuel_level: Int
    var model: String
    var elevation: Float
    
    init(aModel: String, aLevel: Int, anElevation: Float) {     //Constructor
        self.model = aModel
        self.fuel_level = aLevel
        self.elevation = anElevation
    }
    
    func setFuel(_ aLevel: Int)
    {
        self.fuel_level = aLevel
    }
    
    func setElevation(elev: Float)
    {
        self.elevation = elev
    }
    
    func setModel(mod: String)
    {
        self.model = mod
    }
    
    func getFuel() -> Int
    {
        return self.fuel_level
    }
}

var mr = MarsRover(aModel: "1994", aLevel: 100, anElevation: 1300)
mr.setFuel(90)
mr.model = "2000"

print(mr.getFuel())


//Functions:
//https://docs.swift.org/swift-book/LanguageGuide/Functions.html
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}

func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person, alreadyGreeted: false)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))

//Returning Multiple values
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")


//Optionals
func findMax(array: [Int]) -> Int? {
    if array.count == 0 {
        return nil
    }
    var maxVal = 0
    for num in array {
        if num > maxVal{
            maxVal = num
        }
    }
    return maxVal
}

var tmp = findMax(array: [])
print(tmp)

//When we unwrap, the developer guarantees that the optional variable is NOT nil

if let tmpVal = tmp {
    
    print("Array is not empty")
    
} else {
    print("Array is empty")
}

class Street {
    var streetName: String?
}
class House {
    var noOfRooms = 1
    var street: Street?
}
class Person {
    var house: House?
}

//if the Person.house fails, it wil not get to the street
//which can either return a null or the street
let myStreet = Person.house?.street

//to make sure we get a value, we can include the if let like below
if let myStreet = Person.house?.street {
    print(myStreet)
}



//Closures
//https://docs.swift.org/swift-book/LanguageGuide/Closures.html
func fliterWithClosures(closure: (Int) -> Bool, array: [Int]) -> [Int] {
    var subArray = [Int]()
    for num in array {
        if closure(num) {
            subArray.append(num)
        }
    }
    return subArray
}

var test = [12, 34, 56, 1, 33]

var result = fliterWithClosures(closure: { (num) -> Bool in
    return num < 50
}, array: test)

print(result)







