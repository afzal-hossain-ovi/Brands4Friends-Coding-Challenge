//
//  AppMain.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import Foundation

/// App DI Protocol
protocol AppMainProtocol {
    func viewModelDependencies() -> EvenViewModel
}

/// Manage App dependency injection
final class AppMain: AppMainProtocol {
    public static var shared = AppMain()
    
    private init() {}
    
    func viewModelDependencies() -> EvenViewModel {
        let service = EvenService()
        let viewModel = EvenViewModel(service: service)
        return viewModel
    }
}
