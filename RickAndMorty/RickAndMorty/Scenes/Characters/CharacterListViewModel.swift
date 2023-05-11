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


enum CharacterEndpoint: Endpoint {
    
    case getCharacters(page: Int?)
    
    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        }
    }
    
    var urlParameters: [String : String] {
        switch self {
        case .getCharacters(let page?):
            return ["page": String(page)]
        case .getCharacters:
            return [:]
        }
        
    }
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
        
//        debugPrint("Finished request: \(response)")
                
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
        let next: Int?
        
        enum CodingKeys: String, CodingKey {
            case pages
            case count
            case next
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            count = try container.decode(Int.self, forKey: .count)
            pages = try container.decode(Int.self, forKey: .pages)
            
            if
                let nextPageUrl = try? container.decode(URL.self, forKey: .next),
                let nextPageNumberString = nextPageUrl.valueOf(queryParameter: "page"),
                let nextPageNumber = Int(nextPageNumberString)
            {
                self.next = nextPageNumber
            } else {
                self.next = nil
            }
        }
    }
    
    let info: Info
    let results: T
}




@MainActor final class CharacterListViewModel: ObservableObject {

    enum State {
        case initial
        case loading
        case fetched(loadingMore: Bool)
        case failed
    }
    
    @Injected private var apiManager: APIManaging
    
    private var currentPageInfo: Response<[Character]>.Info?
    
    @Published var characters: [Character] = []
    @Published var state: State = .initial
    
    
    func fetchMoreIfNeeded(for character: Character) async {
        
        guard character == characters.last else {
            return
        }
        
        guard let page = currentPageInfo?.next else {
            return
        }
        
        state = .fetched(loadingMore: true)
        
        await fetch(page: page)
    }
    
    
    func load() async {
        state = .loading
        await fetch()
    }
    
    
    func fetch(page: Int? = nil) async {
        
        do {
            
            let endpoint = CharacterEndpoint.getCharacters(page: page)
            
            let response: Response<[Character]> = try await apiManager.request(endpoint: endpoint)
            
            currentPageInfo = response.info
            characters += response.results
            
            state = .fetched(loadingMore: false)
        } catch {
            
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled", .info)
                
                state = .fetched(loadingMore: false)
                
                return
            }
            
            print(error)
            state = .failed
        }
    }
}
