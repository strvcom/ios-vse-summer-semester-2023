//: [Previous](@previous)
//: # Operators, common methods
import Foundation

//: ## Operators
//: ### Arithmetic operators
example(of: "Arithmetic operators") {
    print(1 + 1)
    print(1 - 1)
    print(1 * 1)
    // Integer division
    print(1 / 3)
    // Decimal number division
    print(1.0 / 3.0)
    // Modulo (Zbytek po deleni)
    print(7 % 3)
    
    let integer: Int = 1
    let double: Double = 3
    // We cannot add values of different types
    // print(integer + double)
    
    // But we can change make Double from Integer and then it works
    print(Double(integer) + double)
}

//: ### Plus vs. other data types
example(of: "Plus vs. other data types") {
    // We can use plus to combine also other data types
    print("1" + "1")
    print([1] + [1])
}

//: ### Compound assignment
example(of: "Compound assignment") {
    var one = 1
    
    // To add 1 to the current value of `one` variable we could write `one = one + 1`
    // Or we can use this shorter form
    one += 1
    
    print(one)
}

//: ### Comparison operators
example(of: "Comparison") {
    // All comparison operators return Boolean, i.e. true or false
    
    // Equal
    print(1 == 1)
    // Not equal
    print(2 != 1)
    // Left side is greater than the right side
    print(2 > 1)
    // Left side is less than the right side
    print(1 < 2)
    // Left side is greater than or equal to the right side
    print(1 >= 1)
    // Left side is less than or equal to the the right side
    print(2 <= 1)
}

//: ### Ternary conditional operator
example(of: "Ternary conditional operator") {
    let a = 3
    let b = 4
    
    // Store the greater number to `max` variable
    let max: Int
    if a > b {
        max = a
    } else {
        max = b
    }
    print(max)
    
    // Or we can use much shorter version instead
    // You can read it like this:
    // Is `a` greater than `b` "?" Assign `a` ":" Assign `b`
    let optimizedMax = a > b ? a : b
    print(optimizedMax)
}

//: ### Nil-Coalescing operator
example(of: "Nil-Coalescing operator") {
    let optionalString: String? = "Name"
    print(optionalString.debugDescription)
    
    // We can use the ternary optional operator and the forbidden "!" sign to unwrap the value
    let forceUnwrappedString = optionalString == nil ? "default" : optionalString!
    print(forceUnwrappedString)
    
    // Or we can use "??" operator
    // You can read it like this
    // If there is any non-nil value in `optionalString` please unwrap it "??" Otherwise, use this default value
    let resultString = optionalString ?? "default"
    print(resultString)
}

//: ### Logical operators
example(of: "Logical operators") {
    // Negate
    print(!true)
    
    // Logical AND
    // true && true -> true
    // true && false -> false
    // false && true -> false
    // false && false -> false
    print(true && false)
    
    // Logical OR
    // true && true -> true
    // true && false -> true
    // false && true -> true
    // false && false -> false
    print(true || false)
}

//: ## Ranges
// Instantiate an array from range that contains numbers from 0 to 100
let intArray = Array(0...100)
//: ### Closed range
example(of: "Closed range") {
    // Range containing 0, 1, 2, 3
    for index in 0...3 {
        print(index)
    }
    
    // Looping through elements of `intArray` at indexes 30, 31, 32, 33, 34, 35 and 36
    for number in intArray[30...36] {
        print(number)
    }
}

//: ### Half-open range
example(of: "Half-open range") {
    // Range containing 0, 1, 2
    for index in 0..<3 {
        print(index)
    }
    
    // Looping through elements of `intArray` at indexes 30, 31, 32, 33, 34 and 35
    for number in intArray[30..<36] {
        print(number)
    }
}

//: ### One-sided range
example(of: "One-sided range") {
    // Infinite loop from 0 to infinite
    // for index in 0... {
    //     print(index)
    // }

    // Loop `intArray` elements from index 95 to the end of the array
    for number in intArray[95...] {
        print(number)
    }

}

//: ## Collections and functional programming
//: ### Map
example(of: "Map function") {
    // Instantiate an array from range that contains integers from 0 to 10
    let intsToTen = Array(0...10)
    
    // Convert Int array into String array
    // `map` function has one parameter which is a closure
    // In the closure we say that the number should be converted to string
    // As a result we have an array of Strings
    let stringArray = intsToTen.map({ number in
        return String(number)
    })
    
    print(stringArray)
    print(type(of: stringArray))
}

//: ### Compact map
example(of: "Compact map") {
    let names = ["0", "1", "two"]
    
    // We want to create array of Integers from the array of Strings
    // If the string that we want to convert doesn't contain Integer 'nil' is returned
    // As a result we have an array of optional Integers
    // The `$0` is a way to access unnamed parameter because we didn't write anything like "{ number in" as we did in the example above
    let optionalInts = names.map({ Int($0) })
    print(optionalInts)
    print(type(of: optionalInts))
    
    // When we use `compactMap` instead of `map`, all `nil` values are removed and the resulting array is array of Integers instead of optional Integers
    let ints = names.compactMap({ Int($0) })
    print(ints)
    print(type(of: ints))
}

//: ### Functional programming
example(of: "Functional programming") {
    let array = Array(0...100)
    
    // You can combine as many functions as you want
    let magic = array
        // Multiply each element by 2
        .map({ $0 * 2 })
        // Choose only those elements that are dividable by 2
        .filter({ ($0 % 2) == 0 })
        // Shuffle the elements
        .shuffled()
    
    print(magic)
}

//: ### Functional vs. on-place methods
example(of: "Functional vs. on-place methods") {
    let array = Array(0...10).shuffled()
    
    // Create new array where the elements are sorted but keep the original array untouched
    let sortedArray = array.sorted()
    print(array)
    print(sortedArray)
    
    var arrayToBeSorted = Array(0...10).shuffled()
    // Sort the existing array
    // `arrayToBeSorted` must be `var` because we modify it
    arrayToBeSorted.sort()
    print(arrayToBeSorted)
}
