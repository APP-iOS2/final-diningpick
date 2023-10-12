//
//  SortingPickerButton.swift
//  DiningPick
//
//  Created by 한현민 on 10/12/23.
//

import SwiftUI

enum SortingOption {
    case asc
    case desc
    
    var description: String {
        switch self {
        case .asc:
            return "오름차순"
        case .desc:
            return "내림차순"
        }
    }
}

struct SortingOptionPickerButton: View {
    var selected: SortingOption
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8.0)
                .fill(Color.lightGray)
                .stroke(Color.mediumGray, style: StrokeStyle(lineWidth: 0.5))
                .frame(maxHeight: 30)
                
            HStack(spacing: 4) {
                Image(systemName: "arrow.up.arrow.down")
                    .foregroundStyle(Color.gray)
                
                Text("\(selected.description)")
            }
            .font(.system(size: 14))
        }
    }
}

#Preview {
    SortingOptionPickerButton(selected: .desc)
}
