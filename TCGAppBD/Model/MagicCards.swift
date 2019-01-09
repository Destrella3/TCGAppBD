//
//  MagicCards.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct MagicCards: Codable {
    let cards: [MagicCard]
}

struct MagicCard: Codable {
    let imageUrl: String?
    let foreignNames: [ForeignNames]
}

struct ForeignNames: Codable {
    let name: String
    let text: String
    let language: String
    let imageUrl: String
}
