//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Gleb on 11.05.2023.
//

import Foundation

protocol APIManaging {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class APIManager: APIManaging {

    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        
        return URLSession(configuration: config)
    }()
    
    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        
        let request = try endpoint.asURLRequest()
        
        let (data, response) = try await session.data(for: request)
        
        let httpResponse = response as? HTTPURLResponse
        
        debugPrint("Finished request: \(response)")
                
        guard let status =  httpResponse?.statusCode, (200...299).contains(status) else {
            throw APIError.unaceptableStatusCode
        }
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(T.self, from: data)

            return result
        } catch {
            throw APIError.decodingFailed(error: error)
        }
    }
}
