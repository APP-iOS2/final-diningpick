//
//  CustomerTabView.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import SwiftUI

struct CustomerTabView: View {
    @State private var currentIndex: Int = 1
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            TabView {
                CustomerFeedView()
                    .tabItem {
                    Image(systemName: "house.fill")
                    Text("피드")
                }
                CustomerStoreListView()
                    .tabItem {
                    Image(systemName: "list.bullet")
                    Text("매장 목록")
                }
                CustomerAlarmView()
                    .tabItem {
                    Image(systemName: "bell.fill")
                    Text("알림")
                }
                CustomerProfileView()
                    .tabItem {
                    Image(systemName: "person.fill")
                    Text("내 정보")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("로그아웃") {
                        dismiss()
                    }
                }
            }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CustomerTabView()
}
