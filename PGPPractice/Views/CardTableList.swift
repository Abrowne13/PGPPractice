//
//  CardTableList.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 8/23/26.
//

import SwiftUI

struct CardTableList: View {
    @StateObject private var viewModel = CardTableListViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                List(content: {
                    NavigationLink(destination: CardTableView()) {
                        Text("Setting Hands")
                    }
                    
                    NavigationLink(destination: CSACardTableView()) {
                        Text("CSA")
                    }
                })
            }
        }
    }
}
