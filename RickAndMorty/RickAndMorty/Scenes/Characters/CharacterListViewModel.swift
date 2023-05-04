//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Gleb on 27.04.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

enum HTTPHeader {
    enum HeaderField: String {
        case contentType = "Content-Type"
    }

    enum ContentType: String {
        case json = "application/json"
        case text = "text/html;charset=utf-8"
    }
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [String: String] { get }
    
    func asURLRequest() throws -> URLRequest
}

extension Endpoint {
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var urlParameters: [String: String] {
        [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = Constants.baseAPIUrl.appendingPathComponent(path)

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIError.invalidUrlComponents
        }

        if !urlParameters.isEmpty {
            urlComponents.queryItems = urlParameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
        }

        guard let url = urlComponents.url else {
            throw APIError.invalidUrlComponents
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        request.setValue(
            HTTPHeader.ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeader.HeaderField.contentType.rawValue
        )

        return request
    }
}


protocol APIManaging {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

enum APIError: Error {
    case unaceptableStatusCode
    case decodingFailed(error: Error)
    case invalidUrlComponents
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

struct Response<T: Decodable>: Decodable {
    
    struct Info: Decodable {
        let pages: Int
        let count: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: T
}


enum CharacterEndpoint: Endpoint {
    
    case getCharacters
    
    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        }
    }
}

@MainActor final class CharacterListViewModel: ObservableObject {

    enum State {
        case initial
        case loading
        case fetched(characters: [Character])
        case failed
    }
    
    @Published var state: State = .initial
    
    func fetch() async {
        state = .loading

        
        let url = Constants.baseAPIUrl.appendingPathComponent("character")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        do {
        
//            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//            let decoder = JSONDecoder()
//            let paginatedResponse = try decoder.decode(Response<[Character]>.self, from: data)
//
//            let characters = paginatedResponse.results
            
            let manager = APIManager()
            let resp: Response<[Character]> = try await manager.request(endpoint: CharacterEndpoint.getCharacters)
            
            state = .fetched(characters: resp.results)
        } catch {
            print(error)
            state = .failed
        }
    }
}
