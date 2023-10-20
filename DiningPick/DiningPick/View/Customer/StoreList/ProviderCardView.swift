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
    var provider: Provider

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 1.0))
                .foregroundStyle(Color.mediumGray)
                .backgroundStyle(.background)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(provider.name)
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack {
                    Text(provider.location.fullAddress)
                    Spacer()
                }

                HStack {
                    Text(provider.time.operatingTimeString)
                        .fontWeight(.bold)
                    Spacer()
                }
                

                HStack {
                    Text(provider.time.lastOrderTimeString)
                    Spacer()
                }

                HStack {
                    Text(provider.time.breakTimeString)
                    Spacer()
                }
            }
            .padding()
        }
    }

    fileprivate func getHeight(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height / 4
    }
}

#Preview {
    ProviderCardView(provider: .sampleSimpleData)
}
