//
//  CustomerFeedView.swift
//  DiningPick
//
//  Created by 한현민 on 10/6/23.
//

import SwiftUI

struct CustomerFeedView: View {
    var body: some View {
        NavigationView {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 60))
                        VStack(alignment: .leading) {
                            HStack {
                                Text("OO백반")
                                    .bold()
                                Button {
                                    
                                } label: {
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                                        .padding(.horizontal, 100)
                                }
                               
                            }
                            Text("2023년 10월 5일 오후 3:17")
                                .padding(.vertical, 2)
                        }
                        .font(.system(size: 15))
                        
                    }
                }
            }
            .navigationBarTitle("피드", displayMode: .inline)
        }
    }
}

#Preview {
    CustomerFeedView()
}
