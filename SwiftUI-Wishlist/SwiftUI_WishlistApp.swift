//
//  SwiftUI_WishlistApp.swift
//  SwiftUI-Wishlist
//
//  Created by Monir Haider Helalee on 14/3/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftUI_WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
