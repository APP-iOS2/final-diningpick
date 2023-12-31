//
//  CustomerTabView.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import SwiftUI

struct CustomerTabView: View {
    @EnvironmentObject var accountStore: AccountStore
    @EnvironmentObject var customerStore: CustomerStore
    
    @State private var currentIndex: Int = 1
    
    // CustomerSubscribeProviderListView에서 사용
    @State private var isShowingAddSheet: Bool = false
    
    // TabBar 불투명하게 만들기 (원래는 반투명)
    init() {
        let opaqueAppearance = UITabBarAppearance()
        opaqueAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = opaqueAppearance
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            CustomerFeedView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("피드")
                }.tag(1)
                
            CustomerSubscribeProviderListView(isShowingSheet: $isShowingAddSheet)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("매장 목록")
                }.tag(2)
            
            CustomerNotificationView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("알림")
                }.tag(3)
        }
        .navigationTitle("다이닝픽")
        .navigationBarBackButtonHidden()
        .toolbarBackground(.background, for: .navigationBar)    // 툴바 불투명하게 만들기
        // currentIndex가 TabView의 selection에 binding됨으로써, 선택된 화면별로 다른 toolbar 버튼들을 보여줄 수 있다!
        .toolbar {
            if currentIndex == 2 {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("추가") {
                        isShowingAddSheet.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    CustomerTabView()
}
