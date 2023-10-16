//
//  CutomerFeedBackView.swift
//  DiningPick
//
//  Created by 박재형 on 10/12/23.
//

import SwiftUI
import PhotosUI

struct CutomerFeedBackView: View {
    
    @State private var enabledProviderButton: Bool = false
    @State private var enabledAdminButton: Bool = false
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhoto: UIImage?
    @State private var selectedPhotoArr: [Int] = []
    
    @State private var feedBackText: String = ""
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("건의할 대상")
                        .bold()
                    
                    HStack(spacing: 30) {
                        HStack {
                            Button {
                                enabledProviderButton.toggle()
                            } label: {
                                if !enabledProviderButton {
                                    Image(systemName: "square")
                                } else {
                                    Image(systemName: "checkmark.square.fill")
                                }
                            }
                            Text("사장님")
                                
                        }
                        HStack {
                            Button {
                                enabledAdminButton.toggle()
                            } label: {
                                if !enabledAdminButton {
                                    Image(systemName: "square")
                                } else {
                                    Image(systemName: "checkmark.square.fill")
                                }
                            }
                            Text("관리자")
                        }
                    }
                    .padding(.trailing, 140)
                }
                .feedBackCard(maxHeight: 100)
                .padding(.vertical, 10)
            }
            VStack {
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if selectedItem == nil {
                        Label("사진을 선택해주세요.", systemImage: "photo")
                    } else {
                        if let photo = selectedPhoto {
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)

                        }
                    }
                        
                }
                .foregroundColor(.black)
                .opacity(0.3)
                .feedBackCard(maxHeight: 200)
            }
            .onChange(of: selectedItem) { newItem in
                        Task {
                            guard let imageData = try? await newItem?.loadTransferable(type: Data.self) else { return }
                            selectedPhoto = UIImage(data: imageData)
                        }
                    }
            VStack {
                TextField(text: $feedBackText) {
                    
                }
                .feedBackCard(maxHeight: 300)
                .padding(.vertical, 10)
            }
            
            .navigationBarTitle("구들장흑도야지", displayMode: .inline)
        }
        
    }
}

#Preview {
    CutomerFeedBackView()
}
//selectedPhotoArr.append(1)
