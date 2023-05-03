//
//  EvenService.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import Foundation
import Combine

/// Even Service
final class EvenService: EvenServiceProtocol {
    /// Method returns an even data or an error
    func getEvenData(for number: Int) -> AnyPublisher<EvenResponse, NetworkError> {
        let request = APIRequest(endpoint: .iseven,
                                 method: .get,
                                 pathComponents: ["\(number)"])
        return APIClient
            .shared
            .execute(request, type: EvenResponse.self)
            .eraseToAnyPublisher()
    }
}
