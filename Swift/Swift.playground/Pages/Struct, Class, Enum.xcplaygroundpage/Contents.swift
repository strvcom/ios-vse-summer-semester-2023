//: [Previous](@previous)
//: # Structures, classes, enumerations
import Foundation
//: ## Structures and classes
//: ### Declaration
example(of: "Struct declaration") {
    struct Person {
        let firstName: String
        let lastName: String
    }
    
    // Instantiate
}

example(of: "Struct with explicit initializer") {
    struct Person {
        let firstName: String
        let lastName: String
        
        // Explicit initializer
    }
    
    // Initialize
}

example(of: "Class declaration") {
    class Person {
        let firstName: String
        let lastName: String
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    // Instantiate
}

//: ### Value type vs. reference type
example(of: "Value type") {
    struct Person {
        var firstName: String
        var lastName: String
    }

    // Instantiate
    // Copy instance
    // Modify name
}

example(of: "Reference type") {
    class Person {
        var firstName: String
        var lastName: String
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    // Instantiate
    // Copy instance
    // Modify name
}

//: ### Mutating
example(of: "Mutating structure") {
    struct Person1 {
        let firstName: String
        let lastName: String
    }

    // Instantiate
    // Try to mutate

    struct Person2 {
        var firstName: String
        var lastName: String
        
        // Mutating function
    }
    
    // Instatntiate
    // Mutate
    // Mutate with mutating function
}

example(of: "Mutating class") {
    class Person1 {
        let firstName: String
        let lastName: String
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    // Instantiate
    // Try to mutate

    class Person2 {
        var firstName: String
        var lastName: String
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }

        // Update function
    }
    
    // Instatntiate
    // Mutate
    // Mutate with mutating function
}

//: ### Inheritance
example(of: "Inheritance") {
    class Person {
        var firstName: String
        var lastName: String
        
        init() {
            self.firstName = "Jan"
            self.lastName = "Schwarz"
        }
    }
    
    class UppercasedPerson: Person {
        override init() {
            super.init()
            
            self.firstName = "JAN"
            self.lastName = "SCHWARZ"
        }
    }
    
    // Instantiate
}

example(of: "Struct inheritance") {
    struct Person {
        var firstName: String
        var lastName: String
    }

    struct UppercasedPerson {
    }
    
    // Try to inherit
}

//: ## Enumerations
//: ### Declaration
example(of: "Enum declaration") {
    // Enum with iOS languages
    // Assign to variable
    // Switch statement
}

//: ### Enum with raw value
example(of: "Enum with raw value") {
    // Enum with iOS languages with raw value
    // Initialize with raw value
    // Unknown raw value
}

//: ### Enum with associated value
example(of: "Enum with associated value") {
    // Enum with languages
    // Enum with platforms
    // Assign to variable
    // Switch
}

//: [Next](@next)
