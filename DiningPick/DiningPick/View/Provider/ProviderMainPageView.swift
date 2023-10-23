//
//  ProviderMainPageView.swift
//  DiningPick
//
//  Created by 한현민 on 10/19/23.
//

import SwiftUI

struct ProviderMainPageView: View {
    enum TabInfo: CaseIterable {
        case left
        case center
        case right
        
        var label: String {
            switch self {
            case .left:
                return "소개"
            case .center:
                return "공지사항"
            case .right:
                return "메뉴"
            }
        }
    }
    
    @Binding var provider: Provider
    
    @EnvironmentObject private var customerStore: CustomerStore
    @EnvironmentObject private var providerStore: ProviderStore
    
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
                        IntroduceView()
                    case .center:
                        NoticeView()
                    case .right:
                        MenuView()
                    }
                }
                .padding(.top)
                .refreshable {}
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Text("구독")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("닫기")
                    }
                }
            }
            .padding()
            .navigationTitle(provider.name)
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
    private func IntroduceView() -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                // 프로필 사진
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text(provider.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text(provider.description)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            
            VStack(spacing: 12) {
                Text("영업 시간")
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 12) {
                    HStack {
                        Text("여는 시간")
                            .bold()
                        Spacer()
                        Text(slicingBehindOfLabel(from: provider.time.operatingTimeString))
                    }
                    
                    HStack {
                        Text("주문 마감")
                            .bold()
                        Spacer()
                        Text(slicingBehindOfLabel(from: provider.time.lastOrderTimeString))
                    }
                    
                    HStack {
                        Text("브레이크타임")
                            .bold()
                        Spacer()
                        Text(slicingBehindOfLabel(from: provider.time.breakTimeString))
                    }
                }
                .padding(.horizontal)
            }
                        
            VStack(spacing: 12) {
                Text("가게 주소")
                    .font(.title2)
                    .bold()

                Text(provider.location.fullAddress)
            }
            
            VStack(spacing: 12) {
                Text("가게 연락처")
                    .font(.title2)
                    .bold()
                
                Text(provider.phoneNumber)
            }
        }
    }
    
    @ViewBuilder
    private func NoticeView() -> some View {
        ForEach(provider.noticeArticles) { article in
            VStack(spacing: 10) {
                // 게시글 CardView 부분
                HStack {
                    Text(article.title)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                
                if let imageData = article.image.image {
                    Image(uiImage: UIImage(data: imageData) ?? UIImage())
                        .resizable()
                        .frame(height: 100)
                        .scaledToFit()
                }
                
                HStack {
                    Text(DatetimeHandler.getInstance(locale: .ko_KR, timezone: .Asia_Seoul).getFormattedTimestamp(createdAt: article.date.timeIntervalSince1970, type: .yMdHm))
                    Spacer()
                    HStack(alignment: .center, spacing: 0) {
                        Text("좋아요 ")
                        Text("\(article.likes)")
                            .bold()
                        Text("개")
                    }
                }
                .padding(.bottom, 10)
                
                if let content = article.content {
                    HStack {
                        Text(content)
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 20)
            
            Divider()
        }
    }
    
    @ViewBuilder
    private func MenuView() -> some View {
        ForEach(provider.menuArticles) { article in
            VStack(spacing: 10) {
                // 게시글 CardView 부분
                HStack {
                    Text(article.title)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                
                if let imageData = article.image.image {
                    Image(uiImage: UIImage(data: imageData) ?? UIImage())
                        .resizable()
                        .frame(height: 100)
                        .scaledToFit()
                }
                
                HStack {
                    Text(DatetimeHandler.getInstance(locale: .ko_KR, timezone: .Asia_Seoul).getFormattedTimestamp(createdAt: article.date.timeIntervalSince1970, type: .yMdHm))
                    Spacer()
                    HStack(alignment: .center, spacing: 0) {
                        Text("좋아요 ")
                        Text("\(article.likes)")
                            .bold()
                        Text("개")
                    }
                }
                
//                Divider()
                .padding(.bottom, 10)
                
                if let menus = article.menus {
                    ZStack {
                        RoundedRectangle(cornerRadius: 0.0)
                            // border와 foregroundStyle은 따로 적용
                            // border -> 테두리
                            // foregroundStyle -> 바탕색
                            .border(.accent, width: 4)
                            .foregroundStyle(.background)
                        
//                        Divider()
                        VStack(spacing: 6) {
                            ForEach(menus, id: \.self) { menu in
                                VStack {
                                    Text(menu)
                                        .padding(4)
                                    Divider()
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                if let content = article.content {
                    HStack {
                        Text(content)
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 20)
            
            Divider()
        }
    }
    
    // ex) 브레이크타임 10:09 ~ 18:29 을 인풋으로 받으면,
    // 10:09 ~ 18:29 을 아웃풋으로 반환한다.
    private func slicingBehindOfLabel(from string: String) -> String {
        let tokens = string.split(separator: " ")
        return tokens[1..<tokens.count].joined(separator: " ")
    }
}

#Preview {
    ProviderMainPageView(provider: .constant(.emptyData))
        .environmentObject(CustomerStore())
        .environmentObject(ProviderStore())
}
