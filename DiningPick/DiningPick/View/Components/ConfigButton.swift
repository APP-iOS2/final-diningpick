//
//  ConfigButton.swift
//  DiningPick
//
//  Created by 한현민 on 10/17/23.
//

import SwiftUI

struct ConfigButton: ViewModifier {
    var color: Color
    let radius: CGFloat = 20
    
    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: radius)
            .stroke(style: .init(lineWidth: 0.2))
            .foregroundColor(Color.gray)
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(color)
            )
            .frame(width: 60, height: 40)
        .overlay {
            content
                .foregroundStyle(Color.black)
                .font(.system(size: 14))
                .fontWeight(.bold)
        }
    }
}

extension View {
    func configButton(color: Color) -> some View {
        modifier(ConfigButton(color: color))
    }
}
