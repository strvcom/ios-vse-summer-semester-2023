//: [Previous](@previous)
//: # Collection types
import Foundation
//: ## Arrays
//: ### Declaration
example(of: "Array declaration") {
    var attendees: [String] = ["Tim", "Steve"]
    let _ = []
    
    print(attendees[0])
    attendees[0] = "Cook"
}
//: ### Properties and methods
example(of: "Array properties and methods") {
    var attendees: [String] = ["Tim", "Steve"]
    
    print(attendees.count)
    
    print(attendees.count == 0)
    print(attendees.isEmpty)
    
    // print(attendees[2])
    print(attendees.first.debugDescription)
    if let item = attendees.first {
        print(item)
    }
    
    attendees.append("Craig")
    print(attendees)
    
    attendees.append(contentsOf: ["Jiri", "Vojtech"])
    // attendees = attendees + ["Jiri", "Vojtech"]
    print(attendees)
    
    attendees.insert("Ondrej", at: 0)
    print(attendees)
    
    attendees.remove(at: 0)
    print(attendees)
}
//: ### Loop array
example(of: "Loop array") {
    var attendees: [String] = ["Tim", "Steve"]
    
    for attendee in attendees {
        print(attendee)
    }
    
    for index in 0...(attendees.count-1) {
        print(attendees[index])
    }
    
    for index in 0..<attendees.count {
        print(attendees[index])
    }
    
    for (index, attendee) in attendees.enumerated() {
        print(index, attendee)
    }
}

//: ## Sets
//: ### Declaration
example(of: "Set declaration") {
    var attendees: [String] = ["Tim", "Steve", "Tim"]
    let set = Set(attendees)
    print(set)
}
//: ## Dictionaries
//: ### Declaration
example(of: "Dictionary declaration") {
    var attendees: [String: String] = ["Cook": "Tim", "Jobs": "Steve"]
    let _ = [:]
    
    print(attendees["Cook"].debugDescription)
    print(attendees["Bla"] ?? "Nothing")
    
    attendees["Cook"] = "Timothy"
    attendees["Bla"] = "Huh"
    print(attendees)
}
//: ### Loop
example(of: "Loop dictionary") {
    let attendees: [String: String] = ["Cook": "Tim", "Jobs": "Steve"]
    
    for (key, value) in attendees {
        print(key, value)
    }
}
//: [Next](@next)
