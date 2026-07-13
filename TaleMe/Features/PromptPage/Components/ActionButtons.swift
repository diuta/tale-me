//
//  ActionButtons.swift
//  sengkuyung
//
//  Created by Dimas Putra Aryawan on 07/07/26.
//

import SwiftUI

struct ActionButtons: View {
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: PromptViewModel
    var onOpenHistory: () -> Void = {}

    var body: some View {
        HStack (spacing: 20){
            Button {
                onOpenHistory()
            } label: {
                Image(systemName: "book.pages")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(20)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                    )
            }
            .buttonStyle(.plain)
            
            Button {
                router.navigate(to: .countdown)
            } label: {
                HStack (spacing: 15){
                    Image(systemName: "play.fill")
                        .font(.title)
                    Text("Start")
                        .font(.title)
                }
                .padding(.horizontal, 65)
                .padding(.vertical, 10)
            }
            .buttonStyle(.glass)
            
            Button {
                viewModel.shuffleBoth()
            } label: {
                Image(systemName: "shuffle")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(20)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                    )
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ActionButtons(viewModel: PromptViewModel(), onOpenHistory: {})
        .environmentObject(AppRouter())
}
