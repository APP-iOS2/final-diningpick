//
//  FullSizeButton.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import SwiftUI

struct FullSizeButton: ViewModifier {    
    var color: Color
    
    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: 8)
                .stroke(style: .init(lineWidth: 0.4))
                .foregroundColor(Color.gray)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(color)
                )
                .frame(height: 60)
        .overlay {
            content
                .foregroundStyle(Color.black)
                .font(.system(size: 24))
                .fontWeight(.bold)
        }
    }
}

extension View {
    func fullSizeButton(color: Color) -> some View {
        modifier(FullSizeButton(color: color))
    }
}
