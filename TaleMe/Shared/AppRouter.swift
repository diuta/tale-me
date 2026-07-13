import Foundation
import SwiftUI
import Combine

enum AppRoute: Hashable {
    case prompt
    case countdown
    case recording
    case review
}

class AppRouter: ObservableObject {
    @Published var path: [AppRoute] = []
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
