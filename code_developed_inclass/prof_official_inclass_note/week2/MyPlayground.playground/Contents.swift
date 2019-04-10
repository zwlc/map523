import UIKit

//Variables
var str = "Hello, playground"

var a:Int = 15

var x = 12

//Combining integer with String
print("The value of x is" + String(x))

//Using the backslash character
print("The value of x is \(x) and a+x is \(a+x)")

//Arrays
var array = [35, 36, 4]

//Array Operations
print (array[0])
print (array.count)
array.append(12)
array.remove(at: 3)
array.sort()
print(array)

//Dictionaries
var container = ["School":"Seneca", "Location":"Toronto"]

var knight = [String: Float]()

knight["health"] = 80.0
knight["mana"] = 30.0
knight["Damage"] = 50.0
print (knight)
knight.removeValue(forKey: "mana")
print (knight)

//For loops
for i in 1...100{
    print (i)
}


var numbers = [12, 56, 87, 57]

for i in numbers{
    print(i)
}

for (index, value) in numbers.enumerated() {
    
    numbers[index] += 1
}

print(numbers)



