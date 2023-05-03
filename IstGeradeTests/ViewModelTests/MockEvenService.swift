//
//  MockEvenService.swift
//  IstGeradeTests
//
//  Created by Afzal Hossain on 23.03.23.
//

import Combine
@testable import IstGerade

/// Mock Service 
struct MockEvenService: EvenServiceProtocol {
    var result: Result<EvenResponse, NetworkError>
    
    func getEvenData(for number: Int) -> AnyPublisher<EvenResponse, NetworkError> {
        result.publisher
            .eraseToAnyPublisher()
    }
}

