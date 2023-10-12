//
//  CustomerAlarmView.swift
//  DiningPick
//
//  Created by 박재형 on 10/9/23.
//

import SwiftUI

enum tapInfo : String, CaseIterable {
    case announcement = "공지사항"
    case menu = "메뉴"
}

struct CustomerAlarmView: View {
    
    @State private var selectedPicker: tapInfo = .announcement
    @Namespace private var animation
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                animate()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("매장 목록")
                                }
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                dismiss()
                            } label: {
                                HStack {
                                    
                                    Text("건의하기")
                                }
                            }
                        }
                        
                    }
            }
            .navigationBarTitle("구들장흑도야지", displayMode: .inline)
        }
    }
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(tapInfo.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity/4, minHeight: 40)
                        .foregroundColor(selectedPicker == item ? .black : .gray)

                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.black)
                            .frame(height: 3)
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
    CustomerAlarmView()
}
