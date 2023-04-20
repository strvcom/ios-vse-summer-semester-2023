//: [Previous](@previous)

//: # Generics

import Foundation

//: ### Generics

/// Cache
func store(item: String) -> String {
    print(item)
    return item
}

func store(item: Int) -> Int {
    print(item)
    
    return item
}

// generic function instead of multiple similar implementation
func store<T>(item: T) -> T {
    print(item)
    return item
}

struct Person {
    var name: String
}

// sample with Person type
let person = Person(name: "CJ Parker")
let otherPerson = store(item: person)

print(person)
print(otherPerson)

/// sample of generic struct
struct Queue<T> {
    private var internalArray = [T]()

    var count: Int {
        return internalArray.count
    }

    mutating func add(_ item: T) {
        internalArray.append(item)
    }

    mutating func remove() -> T? {
        if internalArray.count > 0 {
            return internalArray.removeFirst()
        } else {
            return nil
        }
    }
}
/// Here T is resolved as Int
let queue = Queue<Int>()

/// generic with constraint
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        /// working with behavior of Equatable
        if value == valueToFind {
            return index
        }
    }
    return nil
}



//: [Next](@next)
