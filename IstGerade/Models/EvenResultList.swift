//
//  EvenResultList.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import SwiftUI

/// Even Result List Model
struct EvenResultList: Identifiable, Equatable, Hashable {
    var id = UUID()
    let text: String
    let lastWord: String
    let lastWordColor: Color
    let ad: String
}
