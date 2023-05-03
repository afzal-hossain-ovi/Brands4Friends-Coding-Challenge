//
//  EvenListView.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import SwiftUI

/// View to check isEven and show result list
struct EvenListView: View {
    @EnvironmentObject private var evenVM: EvenViewModel
    @FocusState private var numberIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    resultList
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        numberTextField
                        
                        Spacer(minLength: 0)
                        
                        sendButton
                        
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 150)
                }
                
                if evenVM.isFetching {
                    ProgressView()
                        .scaleEffect(2)
                    
                }
                
                if evenVM.isPopUpPresenting {
                    PopUpView(isPresenting: $evenVM.isPopUpPresenting,
                              ad: evenVM.ad)
                }
            }
            .navigationTitle("IstGerade")
            .alert(item: $evenVM.error) { error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription))
            }
        }
    }
}

// MARK: - Result list
extension EvenListView {
    private var resultList: some View {
        List {
            ForEach(evenVM.evenResultList) { result in
                Group {
                    Text(result.text)
                    +
                    Text(result.lastWord)
                        .foregroundColor(result.lastWordColor)
                }
                .accessibilityIdentifier("result_row")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    evenVM.isPopUpPresenting = true
                    evenVM.ad = result.ad
                }
            }
            .onDelete(perform: evenVM.deleteResult(at:))
        }
        .accessibilityIdentifier("result_list")
    }
}

// MARK: - Bottom view
extension EvenListView {
    private var numberTextField: some View {
        TextField("Zahl", text: $evenVM.number)
            .accessibilityIdentifier("number_text_field")
            .focused($numberIsFocused)
            .keyboardType(.numberPad)
            .padding(10)
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 45)
            .modifier(CardStyle())
    }
    
    private var sendButton: some View {
        Button {
            if let number = Int(evenVM.number) {
                evenVM.fetchEvenData(for: number)
            }
            numberIsFocused = false
        } label: {
            Text("Ist diese Zahl gerade?")
                .minimumScaleFactor(0.3)
                .lineLimit(1)
        }
        .accessibilityIdentifier("send_button")
        .padding(10)
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 45)
        .modifier(CardStyle())
        .contentShape(Rectangle())
    }
}

// MARK: - Previews
struct EvenListView_Previews: PreviewProvider {
    static var previews: some View {
        EvenListView()
            .environmentObject(AppMain.shared.viewModelDependencies())
    }
}
