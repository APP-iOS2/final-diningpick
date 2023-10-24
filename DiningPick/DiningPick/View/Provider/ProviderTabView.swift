//
//  ProviderTabView.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import SwiftUI

struct ProviderTabView: View {
    @EnvironmentObject var accountStore: AccountStore
    @EnvironmentObject var providerStore: ProviderStore
    
    @State private var currentIndex: Int = 1
    @State private var isShowingAddSheet: Bool = false
    
    // TabBar 불투명하게 만들기 (원래는 반투명)
    init() {
        let opaqueAppearance = UITabBarAppearance()
        opaqueAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = opaqueAppearance
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ProviderMainPageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }.tag(1)
                
            ProviderEditInformationView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("가게 정보")
                }.tag(2)
            
            ProviderNotificationView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("알림")
                }.tag(3)
        }
        .navigationTitle("\(providerStore.currentProvider.name)")
        .navigationBarBackButtonHidden()
        .toolbarBackground(.background, for: .navigationBar)
    }
}

#Preview {
    ProviderTabView()
        .environmentObject(AccountStore())
        .environmentObject(ProviderStore())
}
