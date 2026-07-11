//
//  ActionButtons.swift
//  sengkuyung
//
//  Created by Dimas Putra Aryawan on 07/07/26.
//

import SwiftUI

struct ActionButtons: View {
    @ObservedObject var viewModel: PromptViewModel
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        HStack (spacing: 20){
            NavigationLink {
                ContentView()
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
            
            NavigationLink {
                CountdownView()
            } label: {
                HStack (spacing: 15){
                    Image(systemName: "play.fill")
                        .font(.title)
                    Text("Start")
                        .font(.title)
                }
                .padding(.horizontal, 65)
                .padding(.vertical, 10)
                //                .foregroundStyle(.primary)?
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
    ActionButtons(viewModel: PromptViewModel())
}
