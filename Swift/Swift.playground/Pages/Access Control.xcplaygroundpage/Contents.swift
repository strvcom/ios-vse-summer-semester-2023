//: [Previous](@previous)
//: # Access control
import Foundation

struct Assignment {
    private var id: String
    internal var title: String
    private(set) var completed: Bool
    
    init(id: String = "1234", title: String = "Title", completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    mutating func complete() {
        self.completed = true
    }
}

//: ### Private
example(of: "Access Control") {
    // Initialize
    // Access id
    // Access completed
    // Modify completed
}

//: [Next](@next)
