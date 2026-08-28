//
//  CSACardTableView.swift
//  PGPPractice
//
//  Created by Ahmed Browne on 10/6/25.
//

import SwiftUI

struct CSACardTableView: View {
    @ObservedObject var viewModel = CSACardTableViewModel()
    @State var isShowingAnswers = false
    @State private var showingRoundInterstital = true
    
    init() {
        _showingRoundInterstital = State(wrappedValue: viewModel.showingRoundInterstitial)
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                viewModel.dealerHairOne
                viewModel.dealerHairTwo
                
                Text("CSA")
                
                Spacer()
                
                Button("Start Round") {
                    viewModel.startRound()
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
                if viewModel.showAnswerButton {
                    Button("Answer") {
                        viewModel.answer()
                        self.isShowingAnswers = true
                    }
                    .popover(isPresented: $isShowingAnswers, arrowEdge: .bottom, content: {
                        Text(viewModel.answerText)
                            .frame(minWidth: 200, minHeight: 100)
                        .presentationCompactAdaptation(.popover)
                    })
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
                
                
                if viewModel.showNextButton {
                    Spacer()
                    Button("Next") {
                        viewModel.next()
                    }
                }
            }
        }
        .padding()
    }
}
