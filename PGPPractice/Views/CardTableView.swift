//
//  CardTableView.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import SwiftUI

struct CardTableView: View {
    @ObservedObject var viewModel = CardTableViewModel()
    @State private var showingAlert = false
    @State private var showingRoundInterstital = true
    init() {
        _showingRoundInterstital = State(wrappedValue: viewModel.showingRoundInterstitial)
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                viewModel.dealerHairOne
                viewModel.dealerHairTwo
                
                Toggle(isOn: $viewModel.hwyToggle) {
                    if viewModel.hwyToggle {
                        Text("HWYB")
                    } else {
                        Text("HWYA")
                    }
                }
            }
            
            HStack {
                viewModel.dealerMainOne
                viewModel.dealerMainTwo
                viewModel.dealerMainThree
                viewModel.dealerMainFour
                viewModel.dealerMainFive
            }
            
            HStack() {
                Button("Answer") {
                    viewModel.answer()
                }
                
                Spacer()
                
                HStack() {
                    viewModel.playerHandOne
                    viewModel.playerHandTwo
                    viewModel.playerHandThree
                    viewModel.playerHandFour
                    viewModel.playerHandFive
                    viewModel.playerHandSix
                    viewModel.playerHandSeven
                }
                
                Spacer()
                
                Button("Next") {
                    viewModel.next()
//                    if viewModel.shouldShowNextHand() {
//                        viewModel.next()
//                    } else {
//                        viewModel.updateRound()
//                        showingRoundInterstital = true
//                    }
                }
            }
        }
        .padding()
    }
}
