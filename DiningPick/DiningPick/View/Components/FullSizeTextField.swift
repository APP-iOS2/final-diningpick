//
//  FullSizeTextField.swift
//  DiningPick
//
//  Created by 한현민 on 10/6/23.
//

import SwiftUI

struct FullSizeTextField: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.lightGray)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 249/255, green: 249/255, blue: 249/255))
                )
                
            content
                .padding()
        }
        .frame(height: 60)
    }
}

extension View {
    func fullSizeTextField() -> some View {
        modifier(FullSizeTextField())
    }
}
