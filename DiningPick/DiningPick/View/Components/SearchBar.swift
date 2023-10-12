//
//  SearchBar.swift
//  DiningPick
//
//  Created by 한현민 on 10/12/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchKeyword: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.lightGray)
                .stroke(.foreground, style: StrokeStyle(lineWidth: 1.0))
                .frame(height: 50)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                
                TextField("검색...", text: $searchKeyword)
                    .padding(.leading, 6)
                
                Spacer()
            }
                
        }
    }
}

#Preview {
    SearchBar(searchKeyword: .constant(""))
}
