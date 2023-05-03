//
//  EvenViewModel.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import SwiftUI
import Combine

/// View Model to handle isEven, result list and view logic
final class EvenViewModel: ObservableObject {
    @Published var number: String = ""
    @Published var ad: String = ""
    @Published var error: NetworkError?
    @Published private (set) var evenResultList: [EvenResultList] = []
    
    @Published private(set) var isFetching: Bool = false
    @Published var isPopUpPresenting: Bool = false
    
    private var cancellable: Set<AnyCancellable> = []
    
    private let service: EvenServiceProtocol
    
    public init(service: EvenServiceProtocol) {
        self.service = service
    }
    
    /// Fetch even data
    public func fetchEvenData(for number: Int) {
        isFetching = true
        
        service.getEvenData(for: number)
            .delay(for: 0.1, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.error = error
                    self.number = ""
                case .finished: break
                }
                
                self.isFetching = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.addResult(with: response)
                self.isFetching = false
                self.number = ""
            }
            .store(in: &cancellable)
    }
    
    /// Add result to the list
    private func addResult(with response: EvenResponse) {
        let lastWord: String = response.iseven ? "gerade!" : "ungerade!"
        let lastWrodColor: Color = response.iseven ? .green : .red
        
        evenResultList.append(
            EvenResultList(text: "Die Zahl \(number) ist ",
                           lastWord: lastWord,
                           lastWordColor: lastWrodColor,
                           ad: response.ad)
        )
        
        showPopUp(with: response.ad)
    }
    
    /// Presenting Popup
    private func showPopUp(with ad: String) {
        self.isPopUpPresenting = true
        self.ad = ad
    }
    
    /// Delete result from the list
    public func deleteResult(at offsets: IndexSet) {
        evenResultList.remove(atOffsets: offsets)
    }
}
