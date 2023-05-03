//
//  PopUpView.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import SwiftUI

/// View to show popup
struct PopUpView: View {
    private let horizontalPadding: CGFloat = 40
    @Binding var isPresenting: Bool
    let ad: String
    
    var body: some View {
        GeometryReader { gr in
            Color.primary
                .opacity(0.15)
                .ignoresSafeArea()
                .animation(.default.delay(0.2), value: isPresenting)
                .onTapGesture {
                    isPresenting = false
                }
            
            let size = gr.size
            
            VStack {
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(.white)
                    .overlay {
                        popUpContents
                    }
            }
            .frame(width: size.width - horizontalPadding, height: size.height / 1.8, alignment: .center)
            .cornerRadius(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

// MARK: - Popup Center Contents
extension PopUpView {
    private var popUpContents: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                isPresenting = false
            } label: {
                Image(systemName: ImageName.iconClose)
                    .font(.largeTitle)
                    .tint(.black)
            }
            .padding(5)
            .accessibilityIdentifier("close_button")
            
            VStack {
                Text("AD")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                Text(ad)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                
                Spacer()
            }
        }
    }
}

// MARK: - Previews
struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(isPresenting: .constant(false),
                  ad: "WILL the person who got hit in the head with a tomato in the 1950\'s please contact 414-555-4536")
    }
}
