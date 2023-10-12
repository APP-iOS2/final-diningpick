//
//  CustomerFindStoreView.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import SwiftUI

struct CustomerFindStoreView: View {
    @EnvironmentObject var customerStore: CustomerStore
    @EnvironmentObject var providerStore: ProviderStore
    @StateObject var searchOptionStore: SearchOptionStore = .init()
    
    @Binding var isShowingSheet: Bool
    
    // 현재 표시중인 Picker
    @State var isShowingPicker: PickerName = .province
    @State var isShowingPickerSheet: Bool = false
    
    @State var searchKeyword: String = ""
    
    // 카드뷰를 클릭하면 구독 추가되면서 현재 sheet 닫힘
    var body: some View {
        NavigationStack {
            // TO DO: sheet 내부 뷰들 구현
            VStack(spacing: 16) {
                // 검색바 -> 만들어둔 ViewModifier 활용
                SearchBar(searchKeyword: $searchKeyword)
                
                // 검색조건 Picker 3개 + Spacer + 정렬 Picker
                HStack(spacing: 6) {
                    Button {
                        isShowingPicker = .province
                        isShowingPickerSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundStyle(Color.gray)
                            
                            Text("\(searchOptionStore.option.province.picked)")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .optionPickerButton()
                    
                    Button {
                        isShowingPicker = .city
                        isShowingPickerSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundStyle(Color.gray)
                            
                            Text("\(searchOptionStore.option.city.picked)")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .optionPickerButton()
                    
                    Button {
                        isShowingPicker = .category
                        isShowingPickerSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundStyle(Color.gray)
                            
                            Text("\(searchOptionStore.option.category.picked)")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .optionPickerButton()
                    
                    Spacer()
                    
                    Button {
                        isShowingPicker = .sorting
                        isShowingPickerSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundStyle(Color.gray)
                            
                            Text("\(searchOptionStore.option.sorting.description)")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .optionPickerButton()
                }
                
                // 가게 목록 ScrollView - LazyVStack - ForEach (pagination 할 수 있음 하고)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("취소") {
                        isShowingSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowingPickerSheet, content: {
                NavigationStack {
                    VStack {
                        switch isShowingPicker {
                        case .province:
                            Picker("지역 선택", selection: $searchOptionStore.option.province.picked, content: {
                                ForEach(Province.pickable, id: \.self) { item in
                                    Text("\(item)")
                                }
                                
                            })
                            .pickerStyle(WheelPickerStyle())
                            
                        case .city:
                            Picker("시/구 선택", selection: $searchOptionStore.option.city.picked, content: { ForEach(City.pickable[searchOptionStore.option.province.picked] ?? [], id: \.self) { item in
                                    Text("\(item)")
                                }
                            })
                            .pickerStyle(WheelPickerStyle())
                            
                        case .category:
                            Picker("맛집 카테고리 선택", selection: $searchOptionStore.option.category.picked, content: { ForEach(Category.pickable, id: \.self) { item in
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
                            
                        default:
                            Text("오류")
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("완료") {
                                isShowingPickerSheet.toggle()
                            }
                        }
                    }
                    .navigationTitle("지역 선택")
                    .navigationBarTitleDisplayMode(.inline)
                }
                
                .presentationDetents([.medium])
            })
            .navigationTitle("매장 찾기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    enum PickerName {
        case province, city, category, sorting
    }
}

#Preview {
    CustomerFindStoreView(isShowingSheet: .constant(true))
}
