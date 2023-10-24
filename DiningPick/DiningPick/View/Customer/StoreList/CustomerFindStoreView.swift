//
//  CustomerFindStoreView.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import SwiftUI

enum PickerName {
    case province, city, category, sorting
    
    var description: String {
        switch self {
        case .province:
            return "지역 선택"
        case .city:
            return "시/군/구 선택"
        case .category:
            return "종류 선택"
        case .sorting:
            return "정렬 방법 선택"
        }
    }
}

struct CustomerFindStoreView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var customerStore: CustomerStore
    @EnvironmentObject var providerStore: ProviderStore
    @StateObject var searchOptionStore: SearchOptionStore = .init()
    
    @State var searchKeyword: String = ""
    
    // 현재 표시중인 Picker
    @State var isShowingPicker: PickerName = .province
    @State var isShowingPickerSheet: Bool = false
    
    // 사용자가 선택한 매장 페이지를 보여주는 sheet
    @State var pickedProvider: Provider = .emptyData
    @State var isShowingProviderSheet: Bool = false
    
    var filteredProviders: [Provider] {
        providerStore.getProvidersBySearchOption(searchOptionStore.option)
    }
    
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
                            
                            Text("\(searchOptionStore.option.location.province.picked)")
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
                            
                            Text("\(searchOptionStore.option.location.city.picked)")
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
                            
                            Text("\(searchOptionStore.option.location.category.picked)")
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
                
                HStack(spacing: 2) {
                    Text("총 ")
                    Text("\(filteredProviders.count)")
                        .foregroundStyle(Color.accentColor)
                        .fontWeight(.bold)
                    Text("개의 매장이 있습니다.")
                }
                
                // 가게 목록 ScrollView - LazyVStack - ForEach (pagination 할 수 있음 하고)
                ScrollView {
                    VStack {
                        ForEach(filteredProviders) { provider in
                            Button {
                                if pickedProvider == provider {
                                    isShowingProviderSheet.toggle()
                                } else {
                                    pickedProvider = provider
                                }
                            } label: {
                                ProviderCardView(provider: provider)
                            }
                            .onChange(of: pickedProvider, {
                                isShowingProviderSheet.toggle()
                            })
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $isShowingPickerSheet, content: {
                CustomerSelectSearchOptionView(isShowingPickerSheet: $isShowingPickerSheet, isShowingPicker: $isShowingPicker, searchOptionStore: searchOptionStore)
                    .presentationDetents([.height(250.0)])
            })
            // NOTE: 값이 늦게 sheet에 전달되는 현상
            // -> if let ~~ 구문으로 nil 검사하지 말고, 그냥 뷰를 @Binding 래퍼 씌워서 넘기자
            // 그러면 늦게 전달되더라도 그 뒤에 바로 값이 전달된다.
            .sheet(isPresented: $isShowingProviderSheet, content: {
                CustomerStoreMainView(provider: pickedProvider, navigatedFrom: .sheet)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("매장 찾기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CustomerFindStoreView()
        .environmentObject(CustomerStore())
        .environmentObject(ProviderStore())
}
