//
//  CardImage.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import Foundation
import SwiftUI

struct CardImage: View {
    var imageName = ""
    init(imageName: String) {
        self.imageName = imageName
    }
    
    init(card: Card) {
        self.imageName = "\(card.suit)_\(card.rank)"
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 75, height: 112)
    }
    
}
