//
//  CustomerSelectSearchOptionView.swift
//  DiningPick
//
//  Created by 한현민 on 10/23/23.
//

import SwiftUI

struct CustomerSelectSearchOptionView: View {
    @Binding var isShowingPickerSheet: Bool
    @Binding var isShowingPicker: PickerName
    @ObservedObject var searchOptionStore: SearchOptionStore
    
    var body: some View {
        NavigationStack {
            VStack {
                switch isShowingPicker {
                case .province:
                    Picker("지역 선택", selection: $searchOptionStore.option.location.province.picked, content: {
                        ForEach(Province.pickable, id: \.self) { item in
                            Text("\(item)")
                        }
                    })
                    .pickerStyle(WheelPickerStyle())
                    .onChange(of: searchOptionStore.option.location.province.picked) { _, picked in
                        searchOptionStore.option.location.city.picked = City.pickable[picked]![0]
                    }
                    
                case .city:
                    Picker("시/구 선택", selection: $searchOptionStore.option.location.city.picked, content: { ForEach(City.pickable[searchOptionStore.option.location.province.picked] ?? [], id: \.self) { item in
                        Text("\(item)")
                    }
                    })
                    .pickerStyle(WheelPickerStyle())
                    
                case .category:
                    Picker("맛집 카테고리 선택", selection: $searchOptionStore.option.location.category.picked, content: { ForEach(Category.pickable, id: \.self) { item in
                        Text("\(item)")
                    }
                    })
                    .pickerStyle(WheelPickerStyle())
                    
                case .sorting:
                    Picker("가게 목록 정렬 방식 선택", selection: $searchOptionStore.option.sorting, content: { ForEach(Sorting.pickable, id: \.self) { item in
                        Text("\(item.description)")
                    }
                    })
                    .pickerStyle(WheelPickerStyle())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        isShowingPickerSheet.toggle()
                    }
                }
            }
            .navigationTitle("\(isShowingPicker.description)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CustomerSelectSearchOptionView(isShowingPickerSheet: .constant(true), isShowingPicker: .constant(.province), searchOptionStore: .init())
}
