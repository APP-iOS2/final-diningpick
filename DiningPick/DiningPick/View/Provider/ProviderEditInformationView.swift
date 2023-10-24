//
//  ProviderEditInformationView.swift
//  DiningPick
//
//  Created by 박재형 on 10/21/23.
//

import SwiftUI

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct ProviderEditInformationView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var providerStore: ProviderStore
    
    var navigatedFrom: NavigatedFrom
    
    @StateObject private var searchOptionStore: SearchOptionStore = .init()
    @State private var currentScreen: CurrentScreen = .display
    @State private var currentPicker: CurrentPicker = .category
    @State private var isShowingPickerSheet: Bool = false
    
    // 편집 모드에서 수정하는 항목
    @State private var description: String = ""
    @State private var openingTime: Date = .init(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 100000)
    @State private var closingTime: Date = .now
    @State private var lastOrderTime: Date = .now
    @State private var breakStartTime: Date = .init(timeIntervalSince1970: Date.now.timeIntervalSince1970 - 100000)
    @State private var breakEndTime: Date = .now
    @State private var addressProvince: String = Province.pickable[0]
    @State private var addressCity: String = City.pickable["전체"]![0]
    @State private var addressDetail: String = ""
    @State private var category: String = Category.pickable[0]
    // 전화번호 항목
    @StateObject var phoneFirstNumber: PhoneNumberStore = .init(place: .first)
    @StateObject var phoneSecondNumber: PhoneNumberStore = .init(place: .second)
    @StateObject var phoneThirdNumber: PhoneNumberStore = .init(place: .third)
    
    // 수정 확인 묻기
    @State private var isShowingConfirmAlert: Bool = false
    
    var phoneNumber: String {
        "\(phoneFirstNumber.value)-\(phoneSecondNumber.value)-\(phoneThirdNumber.value)"
    }
    
    var time: Time {
        .init(openTime: openingTime, closeTime: closingTime, lastOrderTime: lastOrderTime, breakTimeStart: breakStartTime, breakTimeEnd: breakEndTime)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if currentScreen == .display {
                        IntroduceView()
                    } else if currentScreen == .edit {
                        EditView()
                    }
                }
            }
            .padding(.vertical)
            .navigationBarTitle("가게 정보", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if currentScreen == .display {
                            currentScreen.toggle()
                        }
                        
                        else if currentScreen == .edit {
                            isShowingConfirmAlert.toggle()
                            // 수정 확인하면 토글
                        }
                    } label: {
                        Text(currentScreen.buttonText)
                    }
                }
            }
            .toolbar {
                if navigatedFrom != .providerLogin {
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
            }
            .onAppear {
                description = providerStore.currentProvider.description
                openingTime = providerStore.currentProvider.time.openTime
                closingTime = providerStore.currentProvider.time.closeTime
                lastOrderTime = providerStore.currentProvider.time.lastOrderTime
                breakStartTime = providerStore.currentProvider.time.breakTimeStart
                breakEndTime = providerStore.currentProvider.time.breakTimeEnd
                addressProvince = providerStore.currentProvider.location.province.picked
                addressCity = providerStore.currentProvider.location.city.picked
                addressDetail = providerStore.currentProvider.location.detail ?? ""
                category = providerStore.currentProvider.location.category.picked
                
                let segments = providerStore.currentProvider.phoneNumber.components(separatedBy: "-")
                if segments.count == 3 {
                    phoneFirstNumber.value = segments[0]
                    phoneSecondNumber.value = segments[1]
                    phoneThirdNumber.value = segments[2]
                }
            }
            .sheet(isPresented: $isShowingPickerSheet, content: {
                NavigationStack {
                    VStack {
                        switch currentPicker {
                        case .province:
                            Picker("지역 선택", selection: $searchOptionStore.option.location.province.picked, content: {
                                ForEach(navigatedFrom != .providerLogin ? Province.pickable : Province.locationPickable, id: \.self) { item in
                                    Text("\(item)")
                                }
                            })
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: searchOptionStore.option.location.province.picked) { _, picked in
                                searchOptionStore.option.location.city.picked = City.pickable[picked]![0]
                            }
                            
                        case .city:
                            Picker("시/구 선택", selection: $searchOptionStore.option.location.city.picked, content: {
                                ForEach(
                                    City.locationPickable[searchOptionStore.option.location.province.picked] ?? [], id: \.self)
                                {
                                    item in Text("\(item)")
                                }
                                
//                                ForEach(
//                                    navigatedFrom != .providerLogin ? City.pickable[searchOptionStore.option.location.province.picked] :
//                                        City.locationPickable[searchOptionStore.option.location.province.picked] ?? [], id: \.self)
//                                {
//                                    item in Text("\(item)")
//                                }
                            })
                            .pickerStyle(WheelPickerStyle())
                            
                        case .category:
                            Picker("맛집 카테고리 선택", selection: $searchOptionStore.option.location.category.picked, content: {
                                ForEach(Category.pickable, id: \.self) { item in
                                    Text("\(item)")
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
                    .navigationTitle("\(currentPicker.picked)")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDetents([.height(250.0)])
            })
            .alert("저장하시겠습니까?", isPresented: $isShowingConfirmAlert) {
                Button("저장") {
                    // 뷰모델 저장
                    providerStore.currentProvider.description = description
                    providerStore.currentProvider.location = searchOptionStore.option.location
                    providerStore.currentProvider.time = time
                    providerStore.currentProvider.phoneNumber = phoneNumber
//                    guard let oldValue = providerStore.updateProvider(self.provider) else {
//                        print("오류 발생: \(providerStore.currentProvider.id) Provider 인스턴스가 없습니다.")
//                        isShowingConfirmAlert.toggle()
//                        return
//                    }
                    
//                    debugPrint(self.provider)
                    
                    // alert 닫고 현재 화면을 수정 화면에서 전환
                    currentScreen.toggle()
                    isShowingConfirmAlert.toggle()
                }
                .foregroundStyle(Color.themeAccentColor)
                .bold()
                
                Button("취소", role: .cancel) {
                    isShowingConfirmAlert.toggle()
                }
                .foregroundStyle(Color.themeAccentColor)
                .bold()
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
                
                Text(providerStore.currentProvider.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text(providerStore.currentProvider.description)
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
                        Text(slicingBehindOfLabel(from: providerStore.currentProvider.time.operatingTimeString))
                    }
                    
                    HStack {
                        Text("주문 마감")
                            .bold()
                        Spacer()
                        Text(slicingBehindOfLabel(from: providerStore.currentProvider.time.lastOrderTimeString))
                    }
                    
                    HStack {
                        Text("브레이크타임")
                            .bold()
                        Spacer()
                        Text(slicingBehindOfLabel(from: providerStore.currentProvider.time.breakTimeString))
                    }
                }
                .padding(.horizontal)
            }
                        
            VStack(spacing: 12) {
                Text("가게 주소")
                    .font(.title2)
                    .bold()

                Text(providerStore.currentProvider.location.fullAddress)
            }
            
            VStack(spacing: 12) {
                Text("가게 연락처")
                    .font(.title2)
                    .bold()
                
                Text(providerStore.currentProvider.phoneNumber)
            }
        }
    }

    @ViewBuilder
    private func EditView() -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                // 프로필 사진
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text(providerStore.currentProvider.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Button {
                    currentPicker = .category
                } label: {
                    HStack {
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundStyle(Color.gray)
                        
                        Text("\(searchOptionStore.option.location.category.picked)")
                            .foregroundStyle(Color.primary)
                    }
                }
                .onChange(of: currentPicker) {
                    isShowingPickerSheet.toggle()
                }
                .optionPickerButton()
                .frame(width: Dimensions.pickerButtonWidth, height: Dimensions.pickerButtonHeight)
                
                // 2줄 이상일 때는 TextField 대신 써야한다.
                TextEditor(text: $description)
                    .frame(minHeight: 100)
                    .padding(.horizontal)
            }
            
            VStack(spacing: 12) {
                Text("영업 시간")
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 12) {
                    // in: Range<Date>에서 fatal error 나는 오류
                    // 해결책 -> 여는 시간 하나의 변수에 나머지 변수들을 의존하게 한다.
                    DatePicker("여는 시간", selection: $openingTime, displayedComponents: .hourAndMinute)
                        .onChange(of: openingTime) {
                            breakStartTime = openingTime
                        }
                        
                    DatePicker("닫는 시간", selection: $closingTime, in: openingTime..., displayedComponents: .hourAndMinute)
//                        .onChange(of: closingTime) {
//                            breakEndTime = closingTime
//                        }
                        
                    DatePicker("브레이크타임 시작", selection: $breakStartTime, in: openingTime..., displayedComponents: .hourAndMinute)
                        
                    DatePicker("브레이크타임 끝", selection: $breakEndTime, in: breakStartTime..., displayedComponents: .hourAndMinute)
                }
                .bold()
                .padding(.horizontal)
            }
                        
            VStack(spacing: 12) {
                Text("가게 주소")
                    .bold()
                    .font(.title2)
                    
                HStack {
                    Text("지역")
                        .bold()
                    Spacer()
                    Button {
                        currentPicker = .province
                    } label: {
                        HStack {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundStyle(Color.gray)
                            
                            Text("\(searchOptionStore.option.location.province.picked)")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .onChange(of: currentPicker) {
                        isShowingPickerSheet.toggle()
                    }
                    .optionPickerButton()
                    .frame(width: Dimensions.pickerButtonWidth, height: Dimensions.pickerButtonHeight)
                }
                
                HStack {
                    Text("시/군/구")
                        .bold()
                    Spacer()
                    Button {
                        currentPicker = .city
                    } label: {
                        HStack {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundStyle(Color.gray)
                            
                            Text("\(searchOptionStore.option.location.city.picked)")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .onChange(of: currentPicker) {
                        isShowingPickerSheet.toggle()
                    }
                    .optionPickerButton()
                    .frame(width: Dimensions.pickerButtonWidth, height: Dimensions.pickerButtonHeight)
                }
                
                HStack {
                    Text("상세 주소")
                        .padding(.trailing)
                    Spacer()
                    TextField(providerStore.currentProvider.location.detail ?? "", text: $searchOptionStore.option.location.detail.toUnwrapped(defaultValue: ""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .center, spacing: 12) {
                Text("가게 연락처")
                    .font(.title2)
                    .bold()
                
                HStack(spacing: 2) {
                    Spacer()
                    PhoneNumberTextField(phoneNumberStore: phoneFirstNumber)
                    Text("-")
                    PhoneNumberTextField(phoneNumberStore: phoneSecondNumber)
                    Text("-")
                    PhoneNumberTextField(phoneNumberStore: phoneThirdNumber)
                    Spacer()
                }
                .keyboardType(.numberPad)
            }
        }
    }
    
    enum CurrentScreen {
        case display
        case edit
        
        var buttonText: String {
            switch self {
            case .display:
                return "수정"
            case .edit:
                return "완료"
            }
        }
        
        mutating func toggle() {
            if self == .display {
                self = .edit
            } else if self == .edit {
                self = .display
            }
        }
    }
    
    enum CurrentPicker {
        case province
        case city
        case category
        
        var picked: String {
            switch self {
            case .province:
                return "지역 선택"
            case .city:
                return "시/군/구 선택"
            case .category:
                return "카테고리 선택"
            }
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
    ProviderEditInformationView(navigatedFrom: .providerLogin)
        .environmentObject(ProviderStore())
}
