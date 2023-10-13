//
//  FeedBackCardView.swift
//  DiningPick
//
//  Created by 박재형 on 10/12/23.
//

import SwiftUI

struct FeedBackCard: ViewModifier {
    
    var maxHeight: CGFloat
    
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 1.0))
                .foregroundStyle(Color.mediumGray)
                .backgroundStyle(.background)
            content
        }
        .frame(maxWidth: 350, maxHeight: maxHeight)
    }
    
}

extension View {
    func feedBackCard(maxHeight: CGFloat) -> some View {
        modifier(FeedBackCard(maxHeight: maxHeight))
    }
}
