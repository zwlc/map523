import UIKit

var str = "Hello, playground"

/*
 // NOTE:
 things we covered in this sem: closure, optional, functions and class, inheritance, protocols, delegation, wrap?(optional)
 */




// class

public class CreditCard {
    var number: String
    var name: String
    var balance: Float
    
    // init is constructor!! constructor like i did back in c++ or java or etc
    init(aNumber: String, aName: String, aBalance: Float)
    {
        self.name = aNumber
        self.name = aName
        self.balance = aBalance
    }
    
    // simple function that return balance
    func getBalance() -> Float
    {
        return self.balance
    }
    
    func setBalance(newBalance: Float) {
        self.balance = newBalance
    }
}


// inheritance!!!
// this is child class of credit card, inherits creditcard
public class RewardCard : CreditCard
{
    var points: Int
    
    // again, init is constructor. but here, it's for child class
    init(somePoint: Int)
    {
        self.points = somePoint
        super.init(aNumber: "11111", aName: "Alex", aBalance: 1000.0)
    }
    
    // overriding
    override func getBalance() -> Float
    {
        //        super.name = "ABCD" // doesn't make sence but showing you an example
        return 0.0
    }
    
}



// interface
/* you konw in java right?
 view in the class? view on the class?
 
 interface has NO IMPLEMENTATION!!! remember things back in c++... frame?
 */
// in swift, interface is called, protocol!
// protocol (same meaning as interface)
protocol SpaceCraft
{
    
    var fuel_level: Int{get set} // i want it to be gettable and settable. (mutate!)
    var model: String {get set}
    var elevation: Float{get set}
    
    //    func launch() // no implementation because it's interface.
    
    // mutate
    mutating func setFuel(_: Int)
}



public class MarsRover : SpaceCraft
{
    var fuel_level: Int
    var model: String
    var elevation: Float
    
    init(aModel: String, aLevel: Int, anElevation: Float)
    {
        self.model = aModel
        self.fuel_level = aLevel
        self.elevation = anElevation
    }
    
    func setFuel(newVal: Int)
    {
        self.fuel_level = newVal
    }
}


var mr = MarsRover(aModel: "1990", aLevel: 100, anElevation: 12000)
mr.setFuel(newVal: 90)
print (mr.fuel_level)


// functions
// function syntax that return two things
func minMax(array: [Int]) -> (min: Int, max: Int)
{
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count]{
        if value < currentMin{
            currentMin = value
        }
        else if value > currentMax{
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}

let values = minMax(array: [1, 9, 90, 25])
print(values.min)
print(values.max)





// optionals:
/*
 in java...
 CreditCard card = null; // this works
 but in swift, it's lilbit different
 
 in swift, there is if
 
 var card: CreditCard // this means, card can't have null. if there is null value, program crashes
 var card?: CreditCard // this means, card can have null. PUT QUESTION MARK!
 
 */
var minVal: Int? // put question mark there, then you can have 'nil' value ... different from java or other familiar language

func findMax(array: [Int]) -> Int?{ // you put question mark here so this function INT! or NIL!
    
    // what if there is no value in array, what should i return? in java you return null...
    if array.count == 0{
        return nil
    }
    
    var maxVal = 0
    for num in Array{
        if num > maxVal{
            maxVal = num
        }
    }
    return maxVal
}




// fuck this part. i don't know
var max_elem: Int?

max_elem = findMax(array:[12, 45, 69])

var test2 = findMax(array: [])
print(test2!)

var x = 2 + max_elem!

print(x)




// closures
// pass point to function... blabla
// example: give function array, find min and max value
//func filterWithClosures(closure: (Int) -> Bool, array: [Int]) -> [Int]{ // it returns array of integer
//
//}
func filterWithClosures(g: (Int) -> Bool, array: [Int]) -> [Int]{ // it returns array of integer
    var subArray = [Int]()
    for num in array{
        if g(num){
            subArray.append(num)
        }
    }
    return subArray
}

var result = filterWithClosures(g: {(num) -> Bool in
    return num < 30
    
}, array: [12, 34, 56, 1, 33])
// assume that num is value that pass to my function
// and then there is 'in', after the 'in', there is body of function

print(result)
