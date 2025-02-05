//
//  NetworkingServices.swift
//  SampleApp-SwiftUI
//
//  Created by Mohammad Alabed on 04/02/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(apiRequest: BaseRequest) async throws -> T
}

struct NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
    
    private var sharedHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    private var session: URLSession = URLSession.shared
    
    func buildRequest(from apiRequest: BaseRequest) -> URLRequest? {
        // Construct the base URL using the endpoint
        guard var urlComponents = URLComponents(string: "\(baseURL)\(apiRequest.endpoint.rawValue)") else {
            return nil
        }
        
        // Create an array to hold query items (parameters)
        var queryItems = [URLQueryItem]()
        
        // Add parameters from apiRequest.additionalHeaders as query parameters (or you could use other data sources)
        for (key, value) in apiRequest.queryItems {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        // Assign the query items to the URL components
        urlComponents.queryItems = queryItems
        
        // Make sure the URL is valid
        guard let url = urlComponents.url else {
            return nil
        }
        
        // Create the request with the constructed URL
        var request = URLRequest(url: url)
        
        // Append additional headers from the apiRequest
        for (key, value) in apiRequest.additionalHeaders {
            request.allHTTPHeaderFields?[key] = value
        }
        
        request.httpMethod = apiRequest.httpMethod.rawValue
        return request
    }
    func fetch<T: Decodable>(apiRequest: BaseRequest) async throws -> T {
        guard let request = buildRequest(from: apiRequest) else {
            throw CustomError.invalidURL
        }
        print("request: \(String(describing: request.url))")
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw CustomError.networkFailure(description: "Invalid response: \(response)")
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw CustomError.decodingError
            }
        } catch let error as URLError {
            throw CustomError.networkFailure(description: error.localizedDescription)
        } catch {
            throw CustomError.unknownError
        }
    }
}
