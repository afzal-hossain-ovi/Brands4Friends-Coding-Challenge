//
//  APIRequest.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import Foundation

/// Object that represents the single API call
final class APIRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://api.isevenapi.xyz/api/"
    }
    
    /// Desired endpoint
    private let endpoint: APIEndpoint
    
    /// Desired http method
    public let method: HTTPMethod
    
    /// Path Components for API, If Any
    private let pathComponents: [String]
    
    /// Constructed url for the API request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        
        return string
    }
    
    /// Computed & Constructed API url
    public var url: URL? {
        URL(string: urlString)
    }
    
    // MARK: - Construct Api Request
    public init(endpoint: APIEndpoint,
                method: HTTPMethod,
                pathComponents: [String] = []) {
        self.endpoint = endpoint
        self.method = method
        self.pathComponents = pathComponents
    }
}
