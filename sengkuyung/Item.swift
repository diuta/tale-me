//
//  Item.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 30/06/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
