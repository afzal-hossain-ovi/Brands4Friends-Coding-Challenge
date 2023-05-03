//
//  CardStyle.swift
//  IstGerade
//
//  Created by Afzal Hossain on 23.03.23.
//

import SwiftUI

/// Custom Modifier to reuse
public struct CardStyle: ViewModifier {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color
    let borderStyle: StrokeStyle
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat

    public init(backgroundColor: Color = .clear,
         cornerRadius: CGFloat = Constants.cardRadius,
         borderWidth: CGFloat = Constants.borderWidth,
         borderColor: Color = .gray,
         borderStyle: StrokeStyle? = nil,
         shadowColor: Color = .clear,
         shadowRadius: CGFloat = Constants.shadowRadius,
         shadowX: CGFloat = Constants.shadowX,
         shadowY: CGFloat = Constants.shadowY) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.borderStyle = borderStyle ?? StrokeStyle(lineWidth: borderWidth)
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowX = shadowX
        self.shadowY = shadowY
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cardRadius)
                    .stroke(borderColor, style: self.borderStyle)
                    .padding(borderWidth)
            )
            .background(
                backgroundColor
                    .cornerRadius(Constants.cardRadius)
                    .padding(borderWidth)
            )
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
    }
}
