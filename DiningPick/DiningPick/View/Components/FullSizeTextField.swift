//
//  FullSizeTextField.swift
//  DiningPick
//
//  Created by 한현민 on 10/6/23.
//

import SwiftUI

enum TextFieldSize {
    case regular, big

    var numeric: CGFloat {
        switch self {
        case .regular:
            return 60
        case .big:
            return 120
        }
    }
}

struct FullSizeTextField: ViewModifier {
    var size: TextFieldSize

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.lightGray)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.lightGray)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.4) // 테두리 추가
                )
                .frame(height: size.numeric)

            content
                .frame(height: size.numeric, alignment: .topLeading)
                .padding(.top, 40)
                .padding(.horizontal, 20)
                .foregroundStyle(Color.black)
        }
        .frame(height: size.numeric)
    }
}

extension View {
    func fullSizeTextField(size: TextFieldSize = .regular) -> some View {
        modifier(FullSizeTextField(size: size))
    }
}
