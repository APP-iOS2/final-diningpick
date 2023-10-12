//
//  OptionPickerButton.swift
//  DiningPick
//
//  Created by 한현민 on 10/12/23.
//

import SwiftUI

struct OptionPickerButton: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8.0)
                .fill(Color.lightGray)
                .stroke(Color.mediumGray, style: StrokeStyle(lineWidth: 0.5))
                .frame(maxHeight: 35)
                
            HStack(spacing: 4) {
                content
            }
            .font(.system(size: 14))
        }
    }
}

extension View {
    func optionPickerButton() -> some View {
        modifier(OptionPickerButton())
    }
}
