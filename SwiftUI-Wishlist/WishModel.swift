//
//  WishModel.swift
//  SwiftUI-Wishlist
//
//  Created by Monir Haider Helalee on 14/3/25.
//

import Foundation
import SwiftData

@Model
class Wish{
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
