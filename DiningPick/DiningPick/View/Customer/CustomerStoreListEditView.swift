//
//  CustomerStoreListEditView.swift
//  DiningPick
//
//  Created by 박재형 on 10/9/23.
//

import SwiftUI

struct CustomerStoreListEditView: View {
    
    @State private var searchStore: String = ""
    
    var body: some View {
        NavigationStack {
            TextField("검색",text: $searchStore)
                .fullSizeTextField()
        }
    }
}
#Preview {
    CustomerStoreListEditView()
}
