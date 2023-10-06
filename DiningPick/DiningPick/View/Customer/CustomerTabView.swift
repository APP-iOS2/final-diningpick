//
//  CustomerTabView.swift
//  DiningPick
//
//  Created by 한현민 on 10/5/23.
//

import SwiftUI

struct CustomerTabView: View {
    @State private var currentIndex: Int = 1
    
    var body: some View {
        NavigationStack {
            TabView {
                tabItem {
                    Image(systemName: "house.fill")
                    Text("피드")
                }.tag(1)
                
                tabItem {
                    Image(systemName: "house.fill")
                    Text("매장 목록")
                }.tag(2)
                
                tabItem {
                    Image(systemName: "house.fill")
                    Text("알림")
                }.tag(3)
                
                tabItem {
                    Image(systemName: "house.fill")
                    Text("내 정보")
                }.tag(4)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CustomerTabView()
}
