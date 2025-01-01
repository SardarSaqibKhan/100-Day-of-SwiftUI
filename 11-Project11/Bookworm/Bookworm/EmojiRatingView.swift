//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by sardar saqib on 01/01/2025.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int
    var body: some View {
        switch rating {
        case 0:
            Text("0")
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        case 5:
            Text("5")
        default:
            Text("0")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 0)
}
