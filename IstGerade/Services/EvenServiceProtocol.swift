//
//  EvenServiceProtocol.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import Foundation
import Combine

protocol EvenServiceProtocol {
    /// Method returns an even data or an error
    func getEvenData(for number: Int) -> AnyPublisher<EvenResponse, NetworkError>
}
