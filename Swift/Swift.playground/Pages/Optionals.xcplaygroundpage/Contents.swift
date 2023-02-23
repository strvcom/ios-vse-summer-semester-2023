//: [Previous](@previous)
//: # Optionals
import Foundation
//: ## Introduction
//: ### Why optionals
example(of: "Type casting") {
    let stringAge = "30"
    let age: Int? = Int(stringAge)
    
    print(age.debugDescription)
    print(type(of: age))
}
//: ### Declare an optional
example(of: "Optional integer") {
    var age: Int?
    
    age = 30
    
    print(age.debugDescription)
    
    age = nil
    
    print(age.debugDescription)
    
//    var nonOptional: Int = 30
//    nonOptional = nil
}
//: ## Unwrapping
//: ### Force unwrap
example(of: "Force unwrap") {
    var age: Int? = 30
    
    if age == nil {
        print("There is nil")
    } else if age! < 25 {
        print("Less than 25")
    } else {
        print(age!)
    }
    
//    age = nil
//    print(age!)
}
//: ### If let
example(of: "If let") {
    var age: Int? = 30
    
    if let unwrappedAge = age {
        print(unwrappedAge)
        print(type(of: unwrappedAge))
    }
}
//: ### Guard let
example(of: "Guard let") {
    var age: Int? = 30
    
    guard let unwrappedAge = age else {
        print("There was nil")
        return
    }
    
    print(unwrappedAge)
    print(type(of: unwrappedAge))
    //
    //
    //
    //
    //
}
//: ## Working with optionals
//: ### Comparison
example(of: "Comparison") {
    var age: Int? = 30
    
    if age == 28 {
        print("There was 28")
    }
}
//: ### Calling function on optional
example(of: "Calling function on optional") {
    var age: Int? = 30
    
    if let age {
        let biggerAge = age.advanced(by: 2)
        print(type(of: age))
        print(type(of: biggerAge))
        print(biggerAge)
    }
    
    let biggerAge = age?.advanced(by: 2)
    print(biggerAge.debugDescription)
    
    let unwrappedBiggerAge = age!.advanced(by: 2)
    print(unwrappedBiggerAge)
    print(type(of: unwrappedBiggerAge))
}
//: ### Implicitly unwrapped optional
example(of: "Implicitly unwrapped optional") {
    var age: Int!
    
    age = 30
    
    print(age.debugDescription)
    print(type(of: age))
    
    if age < 25 {
        print("Less than 25")
    }
    
    let biggerAge = age.advanced(by: 2)
    print(biggerAge)
    print(type(of: biggerAge))
}
//: [Next](@next)
