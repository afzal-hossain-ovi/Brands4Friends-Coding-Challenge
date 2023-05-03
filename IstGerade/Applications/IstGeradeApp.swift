//
//  IstGeradeApp.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import SwiftUI

@main
struct IstGeradeApp: App {
    @StateObject private var viewModel = AppMain.shared.viewModelDependencies()
    
    var body: some Scene {
        WindowGroup {
            EvenListView()
                .environmentObject(viewModel)
        }
    }
}
