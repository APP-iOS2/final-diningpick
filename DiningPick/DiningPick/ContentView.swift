//
//  ContentView.swift
//  DiningPick
//
//  Created by 한현민 on 2023/09/26.
//

import SwiftUI

struct ContentView: View {
    // TO DO: 현재 화면에서 customerStore의 fetch 함수 호출하기
    @StateObject var accountStore: AccountStore = .init()
    @StateObject var customerStore: CustomerStore = .init()
    @StateObject var providerStore: ProviderStore = .init()
    
    @State private var isLoading: Bool = true
        
    var body: some View {
        if !isLoading {
            Image("AppLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .cornerRadius(8)
                .shadow(radius: 4)
                .onAppear {
                    // TO DO: 뷰모델 fetch 이후 isLoading toggle() 호출
                }
        } else {
//            LoginEmailView()
//                .environmentObject(accountStore)
//                .environmentObject(customerStore)
//                .environmentObject(providerStore)
            
            // TODO: 점주 로그인 화면, 게시글 작성 구현, 파이어베이스 연동 완료
            ProviderInformation(provider: Provider.sampleSimpleData)
                .environmentObject(ProviderStore())
        }
    }
}

#Preview {
    ContentView()
}
