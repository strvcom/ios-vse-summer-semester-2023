//
//  DIContainer.swift
//  RickAndMorty
//
//  Created by Gleb on 04.05.2023.
//

import Foundation


@propertyWrapper
struct Injected<T> {
    
    let wrappedValue: T
    
    init() {
        wrappedValue = DIContainer.shared.resolve()
    }
}

class DIContainer {
    
    static let shared: DIContainer = DIContainer()
    
    var dependencies: [String: () -> Any] = [:]
    var cached: [String: Any] = [:]
    
    init() {
        registerDependencies()
    }
    
    func register<T, R>(type: T.Type, isCached: Bool = false, resolver: @escaping () -> R)  {
        
        let name: String = String(describing: type)
        
        dependencies[name] = resolver
        
        if isCached {
            cached[name] = resolver()
        }
    }
    
    func resolve<T>() -> T {
        
        let name = String(describing: T.self)
        
        if let cachedObject = cached[name] as? T {
            return cachedObject
        }
        
        if let resolver = dependencies[name] as? (() -> T) {
            return resolver()
        }
        
        fatalError("Failed to initialize /\(T.self)")
    }
}

extension DIContainer {
    
    func registerDependencies() {
        register(type: APIManaging.self, isCached: true) {
            APIManager()
        }
    }
}
