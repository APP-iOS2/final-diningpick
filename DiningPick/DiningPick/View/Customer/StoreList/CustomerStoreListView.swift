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
        NavigationView {
            NavigationStack {
                Text("현재 구독 중인 가게가 없어요.")
                    .opacity(0.4)
                
                    .sheet(isPresented: $isShowingSheet) {
                        NavigationStack {
                            CustomerFindStoreView()
                                .navigationBarTitle("매장 찾기", displayMode: .inline)
                                .toolbar {
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button("완료") {
                                            isShowingSheet = false
                                        }
                                    }
                                }
                        }
                    }
            }
            .navigationBarTitle("다이닝픽", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("추가") {
                        isShowingSheet = true
                    }
                }
            }
        }
    }
}

#Preview {
    CustomerStoreListView()
}
