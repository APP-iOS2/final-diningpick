//
//  CustomerFeedView.swift
//  DiningPick
//
//  Created by 한현민 on 10/6/23.
//

import SwiftUI

struct CustomerFeedView: View {
    // 다크모드 활성화 여부
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    // TODO: 피드 데이터 모델 만들고 뷰에 연결하기
                    ForEach(0 ..< 10) { _ in
                        // TODO: 카드뷰로 분리하기
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 60))
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("OO백반")
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Button {
                                        isLiked.toggle()
                                    } label: {
                                        HStack(spacing: 4) {
                                            if !isLiked {
                                                Image(systemName: "heart")
                                                    .foregroundColor(.red)
                                            } else {
                                                Image(systemName: "heart.fill")
                                                    .foregroundColor(.red)
                                            }
                                            Text("24")
                                                .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                                        }
                                    }
                                }
                                
                                Text("2023년 10월 5일 오후 3:17")
                                    .padding(.vertical, 2)
                            }
                            .font(.system(size: 15))
                        }
                    }
                }
                .padding(2)
            }
            .refreshable {}
        }
    }
}

#Preview {
    CustomerFeedView()
}
