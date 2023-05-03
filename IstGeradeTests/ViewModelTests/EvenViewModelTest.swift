//
//  EvenViewModelTest.swift
//  IstGeradeTests
//
//  Created by Afzal Hossain on 23.03.23.
//

import XCTest
import Combine
@testable import IstGerade

final class EvenViewModelTest: XCTestCase {
    private var subscriptions: Set<AnyCancellable> = []
    
    override func tearDown() {
        super.tearDown()
        
        subscriptions = []
    }
    
    func testFetchEvenData() throws {
        let service = MockEvenService(result: .success(MockEvenData.evenResponse))
        let viewModel = EvenViewModel(service: service)
        
        let promise = expectation(description: "Even data fetched successfully")
        
        viewModel.number = "6"
        
        if let safeNumber = Int(viewModel.number) {
            viewModel.fetchEvenData(for: safeNumber)
        }
        
        viewModel.$evenResultList
            .sink { _ in
                XCTFail("Should not have any error")
            } receiveValue: { results in
                if results.count > 0 {
                    promise.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        XCTAssertNil(viewModel.error)
        
        wait(for: [promise], timeout: 1)
    }
    
    func testFailedToFetchEvenData() {
        let service = MockEvenService(result: .failure(.decodeError))
        let viewModel = EvenViewModel(service: service)
        
        viewModel.number = "6"
        
        if let safeNumber = Int(viewModel.number) {
            viewModel.fetchEvenData(for: safeNumber)
        }
        
        viewModel.$evenResultList
            .filter { results in
                results.count > 0
            }
            .sink { _ in
                XCTFail("should not have any even data")
            }
            .store(in: &subscriptions)
        
        let promise = expectation(description: "Failed to fetch Even data and received Error")
        
        viewModel.$error
            .filter { error in
                error != nil
            }
            .sink { error in
                XCTAssertEqual(error?.localizedDescription,
                               "There was an error decoding the data returned by the server.")
                promise.fulfill()
            }
            .store(in: &subscriptions)
        
        
        wait(for: [promise], timeout: 1)
    }
    
    func testEvenResultData() throws {
        let service = MockEvenService(result: .success(MockEvenData.evenResponse))
        let viewModel = EvenViewModel(service: service)
        
        viewModel.number = "6"
        
        if let safeNumber = Int(viewModel.number) {
            viewModel.fetchEvenData(for: safeNumber)
        }
        
        let promise = expectation(description: "data added to result list successfully")
        
        viewModel.$evenResultList
            .sink { _ in
                XCTFail("Should not have any error")
            } receiveValue: { results in
                if results.count > 0,
                   let firstResult = results.first {
                    XCTAssertEqual(firstResult.text, "Die Zahl 6 ist ")
                    XCTAssertEqual(firstResult.lastWord, "gerade!")
                    XCTAssertEqual(firstResult.lastWordColor, .green)
                    XCTAssertEqual(firstResult.ad,
                                   "Scarecrow wanted for field in Saskatchewan. Must not be afraid of birds. Email buddybilly@qotmail.com")
                    promise.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        wait(for: [promise], timeout: 1)
    }
}
