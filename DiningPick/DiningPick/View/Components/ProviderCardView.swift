//
//  ProviderCardView.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import SwiftUI

/*
 카드뷰 항목 목록
 - 가게 이름 + 즐겨찾기 여부
 - 가게 주소
 - 공지사항, 메뉴 각각 알림 수신 여부
 - 영업시간 / 주문마감 시간
 - 브레이크타임

 */

// NavigationLink의 label에 넣자
struct ProviderCardView: View {
    var provider: Provider = .sampleData
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .foregroundStyle(Color.blue)
                    .frame(height: 120)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("")
                }
            }
        }
        
        
    }
}

#Preview {
    ProviderCardView()
}
