//
//  CustomerStoreListView.swift
//  DiningPick
//
//  Created by 한현민 on 10/6/23.
//

import SwiftUI

struct CustomerStoreListView: View {
    @State private var isShowingSheet = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Text("현재 구독 중인 가게가 없어요.")
                .opacity(0.4)
                .sheet(isPresented: $isShowingSheet) {
                    CustomerFindStoreView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("추가") {
                            isShowingSheet = true
                        }
                    }
                }
                .navigationBarTitle("다이닝픽")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CustomerStoreListView()
}
