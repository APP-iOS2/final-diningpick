//
//  ProviderInformation.swift
//  DiningPick
//
//  Created by 박재형 on 10/21/23.
//

import SwiftUI

enum TabInfo2: String, CaseIterable {
    case dashBoard = "대시보드"
    case changingInformatino = "정보 수정"
}

struct ProviderInformation: View {
    @State private var selectedPicker: TabInfo2 = .dashBoard
    @Namespace private var animation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                animate()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("홈")
                                }
                            }
                        }
                    }
                
                ScrollView {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 60))
                    VStack {
                        VStack(alignment: .leading) {
                            Text("가게 이름")
                                .font(.system(size: 20))
                                .bold()
                            Text("구들장흑도야지")
                                .fullSizeTextField(size: .regular)
                                .frame(width: 350)
                        }
                        .padding(.vertical, 10)
                        
                        VStack(alignment: .leading) {
                            Text("가게 연락처")
                                .font(.system(size: 20))
                                .bold()
                            Text("032-123-4567")
                                .fullSizeTextField(size: .regular)
                                .frame(width: 350)
                        }
                        .padding(.vertical, 10)
                        
                        Text("가게 주소")
                            .font(.system(size: 20))
                            .bold()
                        Text("경기 용인시 수지구 죽전로 176 죽전프라자 2층")
                            .fullSizeTextField(size: .regular)
                            .frame(width: 350)

                        Text("가게 소개")
                            .font(.system(size: 20))
                            .bold()
                        Text("10년 전통으로 알려진 죽전 맛집")
                            .fullSizeTextField(size: .big)
                            .frame(width: 350)
                    }
                }
            }
            .navigationBarTitle("구들장흑도야지", displayMode: .inline)
        }
    }

    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(TabInfo2.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.system(size: 18))
                        .bold()
                        .frame(maxWidth: .infinity / 4, minHeight: 40)
                        .foregroundColor(selectedPicker == item ? .black : .gray)

                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.black)
                            .frame(height: 1)
                            .matchedGeometryEffect(id: "info", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }
            }
        }
    }
}

#Preview {
    ProviderInformation()
}
