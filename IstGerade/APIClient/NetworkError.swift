//
//  NetworkError.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import Foundation

/// Represents network error
public enum NetworkError: Error, Identifiable, Hashable {
    case urlError
    case responseError
    case decodeError
    case genricError(String)
    
    public var id: NetworkError { self }
    
    public var localizedDescription: String {
        switch self {
        case .urlError:
            return "There was an error with the URL"
        case .responseError:
            return "There was an error with the server's response."
        case .decodeError:
            return "There was an error decoding the data returned by the server."
        case .genricError(let string):
            return string
        }
    }
}
