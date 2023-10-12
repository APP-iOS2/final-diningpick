//
//  SearchOptionStore.swift
//  DiningPick
//
//  Created by 한현민 on 10/12/23.
//

import Foundation

class SearchOptionStore: ObservableObject {
    @Published var option: SearchOption = .sampleData
    
    func applyOption(province: Province?, city: City?, category: Category?) {
        if let province {
            option.province = province
        }
        
        if let city {
            option.city = city
        }
        
        if let category {
            option.category = category
        }
    }
}
