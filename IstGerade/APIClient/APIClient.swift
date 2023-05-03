//
//  APIClient.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import Foundation
import Combine

/// API Client object to get data
final class APIClient {
    public static let shared = APIClient()
    
    private init() {}
    
    /// Send API Call
    public func execute<T: Decodable>(
        _ request: APIRequest,
        type: T.Type) -> AnyPublisher<T, NetworkError> {
            guard let safeUrl = buildRequestUrl(from: request) else {
                return Fail(error: NetworkError.urlError)
                    .eraseToAnyPublisher()
            }
            
            return URLSession
                .shared
                .dataTaskPublisher(for: safeUrl)
                .tryMap { (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200..<299).contains(httpResponse.statusCode) else {
                        throw NetworkError.responseError
                    }
                    
                    return data
                }
            // Decode response
                .decode(type: type.self, decoder: JSONDecoder())
                .mapError { error -> NetworkError in
                    if let _ = error as? DecodingError {
                        return NetworkError.decodeError
                    }
                    
                    return NetworkError.genricError(error.localizedDescription)
                }
                .eraseToAnyPublisher()
        }
    
    /// Constructed URL Request
    private func buildRequestUrl(from req: APIRequest) -> URL? {
        guard let url = req.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = req.method.rawValue
        return request.url
    }
}
