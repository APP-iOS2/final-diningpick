//
//  ContentView.swift
//  DiningPick
//
//  Created by 한현민 on 2023/09/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var accountStore: AccountStore = .init()
    
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
            LoginEmailView()
                .environmentObject(accountStore)
        }
    }
}

#Preview {
    ContentView()
}
