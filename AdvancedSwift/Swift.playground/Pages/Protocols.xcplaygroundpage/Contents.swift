//: # Protocols

import Foundation


//: ### Protocol defitiniton

/// Protocol
/// Try to get setter as well
protocol MyIdentifiable {
    var id: String { get }
    func identify()
}

//: ### Protocol conformation

/// class conforms MyIdentifiable protocol
class Student: MyIdentifiable {

    // implementation of property
    let id: String

    // implementation of method
    func identify() {
        print("My id is \(id)")
    }

    init (id: String) {
        self.id = id
    }
}

/// sample instance
let student = Student(id: "123456")
student.identify()

/// struct conforms MyIdentifiable protocol
struct Lector: MyIdentifiable {

    // implementation of property
    var id: String

    // implementation of method
    func identify() {
        print("My id is \(id)")
    }

    init (id: String) {
        self.id = id
    }
}

/// sample instance
let lector = Lector(id: "CJ")
lector.identify()

/// enum with associated values
enum AnimalEnum {
    case dog
    case cat
    case bird
    case weirdoAnimal(student: Student)
    case MyIdentifiableAnimal(MyIdentifiable)
}

/// sample instance of AnimalEnum
let weirdoAnimal: AnimalEnum = .weirdoAnimal(student: Student(id: "12345"))
print(weirdoAnimal)

/// check if sample animal enum instance is weirdoAnimale and extracts value
if case .weirdoAnimal(let student) = weirdoAnimal {
    student.identify()
    print(student)
}

/// swiftch sample
switch weirdoAnimal {
case .weirdoAnimal(let student):
    print(student)
default:
    break
}

/// enum with raw Int value
enum HttpError: Int {
    case notValid
    case notFound
}

/// enum conforms MyIdentifiable protocol
extension HttpError: MyIdentifiable {
    // implementation of property
    var id: String {
        String(self.rawValue)
    }

    // implementation of method
    func identify() {
        print("My id is \(id)")
    }
}

let error1: HttpError = .notFound
let error2: HttpError = .notValid
print(error1.id == error2.id)
error1.identify()

//: ### Multiple protocol conformation

/// Sample empty protocol
protocol Animals {}

protocol NameProviding {
    var name: String { get }
}

/// Enum conforms all three protocols
struct Human: MyIdentifiable, NameProviding, Animals {
    var id: String {
        UUID().uuidString
    }

    var name: String {
        id
    }

    func identify() {
        print("My id is \(id)")
    }
}

/// sample instance
let human = Human()
human.identify()

/// sample of protocol abstraction in func signature
func createMyIdentifiable() -> MyIdentifiable {
    Human()
}

let abstractedObject = createMyIdentifiable()

/// check if created indentifiable object is also name providing
if abstractedObject is NameProviding {
    print("I can say my name")
}

/// retype sampe
if let retypedObject = abstractedObject as? NameProviding {
    print("I can say my name \(retypedObject.name)")
}

//: ### Typealias

/// Typealis as syntax suger for multiple protocol conformance
typealias NamedAnimal = Animals & MyIdentifiable & NameProviding

struct Owl: NamedAnimal {
    var id: String {
        "owl"
    }

    func identify() {
        print("My id is \(id) and name is \(name)")
    }

    var name: String {
        "Pete"
    }
}

let owl = Owl()
owl.identify()

//: [Next](@next)
