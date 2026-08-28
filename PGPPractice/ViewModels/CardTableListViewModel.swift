//
//  CardTableListViewModel.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 8/23/26.
//

import Foundation

class CardTableListViewModel: ObservableObject {
    @Published var views: [String] = []
    
    init() {
        views = ["CSA", "Setting"]
    }
}
