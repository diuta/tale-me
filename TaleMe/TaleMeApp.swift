//
//  sengkuyungApp.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 30/06/26.
//

import SwiftUI
import SwiftData

@main
struct TaleMeApp: App {
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(router)
        }
        .modelContainer(for: HistoryData.self)
    }
}
