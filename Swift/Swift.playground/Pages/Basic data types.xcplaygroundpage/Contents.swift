//: # Basic data types
import Foundation

//: ### Strings
example(of: "Strings") {
    let name = "Tim Cook"
    print(name)
    print(type(of: name))
    let typedName: String = "Steve Jobs"
    print(typedName)
    
    // typedName = "Different name"
}
//: ### Mutability
example(of: "Mutability") {
    var name = "Tim Cook"
    
    name = "Steve Jobs"
    
    print(name)
}
//: ### Numbers
example(of: "Numbers") {
    let age: Int = 30
    print(type(of: age))
    
    let height = 1.75
    print(type(of: height))
    let floatHeight: Float = 1.75
    print(height)
    print(floatHeight)
}
//: ### Boolean
example(of: "Boolean") {
    var isOld: Bool = false
    print(isOld)
    isOld.toggle()
    print(isOld)
}
//: ### Tuple
example(of: "Tuple") {
    typealias Tuple = (firstName: String, lastName: String)
    let tuple: Tuple = ("Tim", "Cook")
    
    print(tuple)
    print(tuple.firstName, tuple.lastName)
    
    let unnamedTuple: (String, String) = ("Tim", "Cook")
    print(unnamedTuple.0, unnamedTuple.1)
}
//: [Next](@next)
