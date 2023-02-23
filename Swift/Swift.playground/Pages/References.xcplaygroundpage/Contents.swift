//: [Previous](@previous)
//: # References
import Foundation

//: ### Reference counting
example(of: "Reference counting") {
    class Person {
        let name: String
        
        init(name: String) {
            self.name = name
            
            print("Person \(name) initialized")
        }
        
        deinit {
            print("Person \(name) deinitialized")
        }
    }
    
    // We create optional variables so that we can set them to nil
    var person1: Person? = Person(name: "Tim")
    var person2: Person? = person1
    
    print("Setting person1 to nil")
    person1 = nil
    print("Setting person2 to nil")
    person2 = nil
    
    // When we lose the last reference to the instance, it is deallocated
}

//: ### Retain cycle
example(of: "Retain cycle") {
    class Person {
        let name: String
        var image: ProfileImage?
        
        init(name: String) {
            self.name = name
            
            print("Person \(name) initialized")
        }
        
        deinit {
            print("Person \(name) deinitialized")
        }
    }

    class ProfileImage {
        let url: URL?
        var person: Person?
        
        init(url: URL?) {
            self.url = url
            
            print("Image \(self) initialized")
        }
        
        deinit {
            print("Image \(self) deinitialized")
        }
    }
    
    // We create optional variables so that we can set them to nil
    var person: Person? = Person(name: "Tim")
    var image: ProfileImage? = ProfileImage(url: nil)
    
    // Here we refer to image from person
    person?.image = image
    // Here we refer to person from image
    image?.person = person
    // As a result, we have a cycle of references here, so called retail cycle
    
    person = nil
    image = nil
    // Deinit is never called because even though we set the references from `person` and `image` to nil there are still the references from `person.image` to the image and from `image.person` to the person so the automatic reference counting still notes there is 1 reference to each object and the objects can't be deinitialized
}

//: ### Weak reference
example(of: "Weak reference") {
    class Person {
        let name: String
        var image: ProfileImage?
        
        init(name: String) {
            self.name = name
            print("Person \(name) initialized")
        }
        
        deinit {
            print("Person \(name) deinitialized")
        }
    }
    
    class ProfileImage {
        let url: URL?
        // THE TRICK IS HERE WITH THE `weak` KEY WORD
        weak var person: Person?
        // When you mark a variable as `weak`, Swift doesn't add 1 for the reference count even though you assign a reference to the variable
        
        init(url: URL?) {
            self.url = url
            print("Image \(self) initialized")
        }
        
        deinit {
            print("Image \(self) deinitialized")
        }
    }
    
    // We create optional variables so that we can set them to nil
    var person: Person? = Person(name: "Tim")
    var image: ProfileImage? = ProfileImage(url: nil)
    
    // Here we refer to image from person
    person?.image = image
    // Here we refer to person from image
    image?.person = person
    // As a result, we have a cycle of references here, so called retail cycle

    
    person = nil
    image = nil
    // Deinit is called because `image.person` reference is weak so we didn't add 1 to the reference count and since we set `person` to `nil`, Swift believes we have 0 references to the person so it is deinitialized and once the person is deinitialized the `person.image` doesn't refer to the image anymore and the image can be also deinitialized
}

//: ### Reference captured by a closure
example(of: "Reference captured by a closure") {
    class Assignment {
        let title: String
        private(set) var completed: Bool
        var toggleCompletedClosure: (() -> Void)?
        
        init(title: String = "Title", completed: Bool = false) {
            self.title = title
            self.completed = completed
            
            // It might not seem like that but this is also a retain cycle
            // The assignment keeps reference to the `toggleCompletedClosure`
            // The implementation of the closure keeps reference to `self` i.e. the assignment
            // So it is assignment -> closure -> self (i.e. assignment) and we have the cycle
            toggleCompletedClosure = {
                self.completed.toggle()
            }
            
            print("Assignment \(title) initialized")
        }
        
        deinit {
            print("Assignment \(title) deinitialized")
        }
    }

    var assignment: Assignment? = Assignment()
    assignment = nil
    
    // Deinit is never called because of the retain cycle
}

//: ### Weak reference in a closure
example(of: "Weak reference in a closure") {
    class Assignment {
        let title: String
        private(set) var completed: Bool
        var toggleCompletedClosure: (() -> Void)?
        
        init(title: String = "Title", completed: Bool = false) {
            self.title = title
            self.completed = completed
            
            // We can fix it by telling the closure it should reference to self just weakly
            // Every reference that is weak is optional because it can be deinitialized at any time
            toggleCompletedClosure = { [weak self] in
                self?.completed.toggle()
            }
            print("Assignment \(title) initialized")
        }
        
        deinit {
            print("Assignment \(title) deinitialized")
        }
    }

    var assignment: Assignment? = Assignment()
    assignment = nil
    
    // Deinit is called 🎉
}

//: [Next](@next)
