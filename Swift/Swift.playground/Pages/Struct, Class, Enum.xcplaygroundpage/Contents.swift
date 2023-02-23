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
    
    let person = Person(firstName: "Tim", lastName: "Cook")
    print(person)
}

example(of: "Struct with explicit initializer") {
    struct Person {
        let firstName: String
        let lastName: String
        
        init() {
            firstName = "Tim"
            lastName = "Cook"
        }
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    struct Person2 {
        var firstName: String?
        var lastName: String?
    }

    let person = Person()
    print(person)
    
    let person2 = Person2()
    print(person2)
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
    
    let person = Person(firstName: "Tim", lastName: "Cook")
    print(person)
}

//: ### Value type vs. reference type
example(of: "Value type") {
    struct Person {
        var firstName: String
        var lastName: String
    }

    var person = Person(firstName: "Tim", lastName: "Cook")
    var person2 = person
    person.firstName = "Timothy"
    
    print(person)
    print(person2)
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
    
    var person = Person(firstName: "Tim", lastName: "Cook")
    var person2 = person
    person.firstName = "Timothy"
    
    print(person.firstName)
    print(person2.firstName)
}

//: ### Mutating
example(of: "Mutating structure") {
    struct Person1 {
        let firstName: String
        let lastName: String
    }

    let _ = Person1(firstName: "Tim", lastName: "Cook")
    // person.firstName = "Timothy"

    struct Person2 {
        var firstName: String
        var lastName: String
        
        mutating func update() {
            firstName = firstName.uppercased()
        }
    }
    
    var person = Person2(firstName: "Tim", lastName: "Cook")
    person.firstName = "Timothy"
    person.update()
    print(person)
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
    
    let _ = Person1(firstName: "Tim", lastName: "Cook")
    // person.firstName = "Timothy"

    class Person2 {
        var firstName: String
        var lastName: String
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }

        func update() {
            firstName = firstName.uppercased()
        }
    }
    
    let person = Person2(firstName: "Tim", lastName: "Cook")
    person.firstName = "Timothy"
    print(person.firstName)
    person.update()
    print(person.firstName)
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
    
    let uppercasePerson = UppercasedPerson()
    print(uppercasePerson.firstName)
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
    enum Languages {
        case swift
        case objectiveC
    }
    
    let language: Languages = .swift
    print(language)
}

//: ### Enum with raw value
example(of: "Enum with raw value") {
    enum Languages: String {
        case swift = "swift"
        case objectiveC = "objective-C"
    }
    
    let language: Languages = .objectiveC
    print(language.rawValue)
    
    let rawString = "objective-C"
    //let rawString = "objective-CC"
    let lang = Languages(rawValue: rawString)
    print(lang.debugDescription)
}

//: ### Enum with associated value
example(of: "Enum with associated value") {
    enum Platform {
        case iOS(language: iOSLanguages)
        case android(language: AndroidLanguages)
    }
    
    enum iOSLanguages: String {
        case swift, objectiveC
    }
    
    enum AndroidLanguages: String {
        case java, kotlin
    }
    
    let platform = Platform.iOS(language: .swift)
    
    switch platform {
    case .iOS(let language):
        print("We use iOS written in \(language)")
    case .android(let language):
        print("We use Android written in \(language)")
    }
}

//: [Next](@next)
