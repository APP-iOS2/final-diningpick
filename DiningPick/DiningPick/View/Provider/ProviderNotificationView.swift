//
//  ProviderNotificationView.swift
//  DiningPick
//
//  Created by 한현민 on 10/24/23.
//

import SwiftUI

struct ProviderNotificationView: View {
    enum TabInfo: CaseIterable {
        case left
        case right
        
        var label: String {
            switch self {
            case .left:
                return "읽지 않음"
            case .right:
                return "읽음"
            }
        }
    }
    
    @State private var selectedTab: TabInfo = .left
    @Namespace private var animation
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                TabBar()
                
                ScrollView {
                    switch selectedTab {
                    case .left:
                        UnreadNotificationView()
                    case .right:
                        ReadNotificationView()
                    }
                }
                .padding(.top)
                .refreshable {}
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Text("설정")
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 4)
            .navigationTitle("알림")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func TabBar() -> some View {
        HStack {
            ForEach(TabInfo.allCases, id: \.self) { tab in
                VStack {
                    Text(tab.label)
                        .font(.system(size: 18))
                        .bold()
                        .frame(maxWidth: .infinity / 4, minHeight: 20)
                        .foregroundColor(selectedTab == tab ? .black : .gray)

                    if selectedTab == tab {
                        Capsule()
                            .foregroundColor(.black)
                            .frame(height: 1)
                            .matchedGeometryEffect(id: "info", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        self.selectedTab = tab
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func UnreadNotificationView() -> some View {
        // TO DO: 알림 관련 데이터모델 연결
        ForEach(0 ..< 1) { _ in
            VStack(spacing: 10) {
                HStack(alignment: .center, spacing: 14) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("OO백반")
                            .bold()
                        Text("새로운 메뉴가 올라왔습니다.")
                    }
                    
                    Spacer()
                    
                    Text("1분 전")
                        .foregroundStyle(Color.gray)
                }
                
                Divider()
            }
            .padding(.bottom, 10)
        }
    }
    
    @ViewBuilder
    private func ReadNotificationView() -> some View {
        // TO DO: 알림 관련 데이터모델 연결
        ForEach(0 ..< 10) { _ in
            VStack(spacing: 10) {
                HStack(alignment: .center, spacing: 14) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("OO백반")
                            .bold()
                        Text("새로운 메뉴가 올라왔습니다.")
                    }
                    
                    Spacer()
                    
                    Text("1분 전")
                        .foregroundStyle(Color.gray)
                }
                
                Divider()
            }
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    ProviderNotificationView()
}
