//: [Previous](@previous)
//: # Access control
import Foundation

struct Assignment {
    // Private properties (and functions) can be neither accessed nor modified from outside of the object
    private var id: String
    // Internal is the default access control level, you don't need to write it to the definition
    // Internal properties (and functions) can be accessed and modified from outside of the object
    internal var title: String
    // Private(set) means that only the option to set (i.e. modify) the property is private
    // In other words we can access the property from outside but we cannot modify it from outside
    private(set) var completed: Bool
    
    init(id: String = "1234", title: String = "Title", completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    mutating func complete() {
        // We can modify the property as long as we are in the object
        self.completed = true
    }
}

//: ### Private
example(of: "Access Control") {
    var assignment = Assignment()
    
    // We can neither access nor modify `id` because it is private
    // print(assignment.id)
    // assignment.id = "1"
    
    // We can access the `completed`
    print(assignment.completed)
    
    // But we cannot modify `completed` because the option to set it is private
    // assignment.completed = true
    
    // Nevertheless we can call a function of the assignment that modifies it within its body
    assignment.complete()
    
    print(assignment)
}

//: [Next](@next)
