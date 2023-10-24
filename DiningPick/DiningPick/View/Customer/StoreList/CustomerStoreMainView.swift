//
//  CustomerStoreMainView.swift
//  DiningPick
//
//  Created by 한현민 on 10/19/23.
//

import SwiftUI

enum NavigatedFrom {
    case navigationLink
    case sheet
}

struct CustomerStoreMainView: View {
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
    
    enum SubscribeStatus {
        case subscribed
        case unsubscribed
        
        var message: String {
            switch self {
            case .subscribed:
                return "구독을 취소하시겠습니까?"
            case .unsubscribed:
                return "구독하시겠습니까?"
            }
        }
        
        var action: String {
            switch self {
            case .subscribed:
                return "구독 취소"
            case .unsubscribed:
                return "구독"
            }
        }
        
        mutating func toggle() {
            switch self {
            case .subscribed:
                self = .unsubscribed
            case .unsubscribed:
                self = .subscribed
            }
        }
    }
    
    var provider: Provider
    var navigatedFrom: NavigatedFrom
    
    @State var subscribeStatus: SubscribeStatus = .unsubscribed
    
    @EnvironmentObject private var customerStore: CustomerStore
    @EnvironmentObject private var providerStore: ProviderStore
    
    @State private var selectedTab: TabInfo = .left
    @State private var isShowingSubscribeConfirmAlert: Bool = false
    @State private var isShowingErrorAlert: Bool = false
    @State private var errorMessage: String = ""
    
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
                if subscribeStatus == .unsubscribed {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingSubscribeConfirmAlert.toggle()
                        } label: {
                            Text("구독")
                        }
                    }
                            
                } else if subscribeStatus == .subscribed {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingSubscribeConfirmAlert.toggle()
                        } label: {
                            Text("구독 취소")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if navigatedFrom == .sheet {
                        Button {
                            dismiss()
                        } label: {
                            Text("닫기")
                        }
                    }
                }
            }
            .alert(subscribeStatus.message, isPresented: $isShowingSubscribeConfirmAlert, actions: {
                Button(subscribeStatus.action) {
                    switch subscribeStatus {
                    case .unsubscribed:
                        if let error = customerStore.subscribeProvider(providerId: provider.id) {
                            errorMessage = error.description
                            isShowingErrorAlert.toggle()
                        }
                    case .subscribed:
                        if let error = customerStore.unsubscribeProvider(providerId: provider.id) {
                            errorMessage = error.description
                            isShowingErrorAlert.toggle()
                        }
                    }
                    subscribeStatus.toggle()
                    isShowingSubscribeConfirmAlert.toggle()
                }
                
                Button("돌아가기", role: .cancel) {
                    isShowingSubscribeConfirmAlert.toggle()
                }
            })
            .alert("오류", isPresented: $isShowingErrorAlert, actions: {
                Button("확인") {
                    errorMessage = ""
                    isShowingErrorAlert.toggle()
                }
            }, message: {
                Text(errorMessage)
            })
            .onAppear(perform: {
                subscribeStatus = customerStore.didSubscriptionProvider(provider) ? SubscribeStatus.subscribed : SubscribeStatus.unsubscribed
            })
            .padding()
            .navigationTitle(provider.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            debugPrint(provider.id)
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
        return tokens[1 ..< tokens.count].joined(separator: " ")
    }
}

#Preview {
    CustomerStoreMainView(provider: .sampleSimpleData, navigatedFrom: .sheet)
        .environmentObject(CustomerStore())
        .environmentObject(ProviderStore())
}
