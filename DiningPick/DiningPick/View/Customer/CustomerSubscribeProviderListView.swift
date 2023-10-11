//
//  CustomerSubscribeProviderListView.swift
//  DiningPick
//
//  Created by 한현민 on 10/11/23.
//

import SwiftUI

struct CustomerSubscribeProviderListView: View {
    @EnvironmentObject var customerStore: CustomerStore
    @EnvironmentObject var providerStore: ProviderStore

    @Binding var isShowingSheet: Bool

    var body: some View {
        NavigationStack {
            if customerStore.customer.preferences.favoriteProviders.isEmpty {
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            Spacer()
                            Text("현재 구독 중인 가게가 없어요.")
                                .foregroundStyle(Color.gray)
                            Spacer()
                        }
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                    }
                }
            } else {
                // ForEach의 onDelete, onMove는 ScrollView가 감싸고 있을 때는 안 된다.
                // List나 Form으로 ForEach를 감쌀 때에만 작동한다.
                List {
                    ForEach(providerStore.getProvidersByIDs(customerStore.customer.preferences.favoriteProviders)) { provider in
                        ProviderCardView(provider: provider)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: customerStore.removeSubscribe)
                    .onMove(perform: customerStore.onMove)
                }
                .listStyle(.plain)
            }
        }
        .sheet(isPresented: $isShowingSheet, content: {
            CustomerFindStoreView(isShowingSheet: $isShowingSheet)
        })
        .refreshable {
            customerStore.fetchData()
        }
    }
}

#Preview {
    CustomerSubscribeProviderListView(customerStore: .init(), isShowingSheet: .constant(false))
}
