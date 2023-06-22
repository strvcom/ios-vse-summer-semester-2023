//
//  DIContainer.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

final class DIContainer {
    typealias Resolver = () -> Any

    private var resolvers = [String: Resolver]()
    private var cache = [String: Any]()

    static let shared = DIContainer()

    init() {
        registerDependencies()
    }

    func register<T, R>(_ type: T.Type, cached: Bool = false, service: @escaping () -> R) {
        let key = String(reflecting: type)
        resolvers[key] = service

        if cached {
            cache[key] = service()
        }
    }

    func resolve<T>() -> T {
        let key = String(reflecting: T.self)

        if let cachedService = cache[key] as? T {
            print("🥣 Resolving cached instance of \(T.self).")

            return cachedService
        }

        if let resolver = resolvers[key], let service = resolver() as? T {
            print("🥣 Resolving new instance of \(T.self).")

            return service
        }

        fatalError("🥣 \(key) has not been registered.")
    }
}

extension DIContainer {
    func registerDependencies() {
        register(APIManaging.self, cached: true) {
            APIManager()
        }
        
        register(CoreDataManaging.self, cached: true) {
            CoreDataManager()
        }
    }
}
