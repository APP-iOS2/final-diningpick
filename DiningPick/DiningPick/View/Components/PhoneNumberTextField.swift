//
//  PhoneNumberTextField.swift
//  DiningPick
//
//  Created by 한현민 on 10/22/23.
//

import SwiftUI

struct PhoneNumberTextField: View {
    @ObservedObject var phoneNumberStore: PhoneNumberStore

    var body: some View {
        TextField(phoneNumberStore.value, text: $phoneNumberStore.value)
            .keyboardType(.numberPad) // Open the number keyboard
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(Color.gray.opacity(0.5), lineWidth: 2)
            )
            .padding(.horizontal)
            // 해결책) TextField의 onChange()에서 입력값을 직접 검증해야 한다.
            // 만약 PhoneNumberStore의 @Published var value 부분에 didSet {}을 통해 값을 바꾸면, TextField의 focus를 벗어날 때 입력값이 검증된다.
            .onChange(of: phoneNumberStore.value) {
                if phoneNumberStore.value.count > phoneNumberStore.limit {
                    phoneNumberStore.value = String(phoneNumberStore.value.prefix(phoneNumberStore.limit))
                }

                let filtered = phoneNumberStore.value.filter { Set("0123456789").contains($0) }
                if filtered != phoneNumberStore.value {
                    phoneNumberStore.value = filtered
                }
            }
    }
}

#Preview {
    PhoneNumberTextField(phoneNumberStore: .init(place: .first))
}
