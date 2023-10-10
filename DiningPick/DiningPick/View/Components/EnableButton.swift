//
//  EnableButton.swift
//  DiningPick
//
//  Created by 박재형 on 10/6/23.
//

import SwiftUI

struct EnableButton: ViewModifier {
    var color: Color
    
    @State var nickName: String = "a"
    @State var id: String = "a"
    
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
        func EnableButton(color: Color) -> some View {
            modifier(EnableButton(color: color))
        }
    }
