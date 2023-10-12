//
//  CustomerFindStoreView.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import SwiftUI

struct CustomerFindStoreView: View {
    @EnvironmentObject var customerStore: CustomerStore
    @EnvironmentObject var providerStore: ProviderStore
    
    @Binding var isShowingSheet: Bool
    
    // 카드뷰를 클릭하면 구독 추가되면서 현재 sheet 닫힘
    var body: some View {
        NavigationStack {
            // TO DO: sheet 내부 뷰들 구현
            VStack {
                // 검색바 -> 만들어둔 ViewModifier 활용
                
                // 검색조건 Picker 3개 + Spacer + 정렬 Picker
                
                // 가게 목록 ScrollView - LazyVStack - ForEach (pagination 할 수 있음 하고)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("취소") {
                        isShowingSheet.toggle()
                    }
                }
            }
            .navigationTitle("매장 찾기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CustomerFindStoreView(isShowingSheet: .constant(true))
}
