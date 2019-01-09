//
//  PokemonCards.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct PokemonCards : Codable {
    let cards : [PokeCard]
}
struct PokeCard: Codable {
    let imageUrl: String
    let imageUrlHiRes: String
    let attacks: [Attack]
}
struct Attack: Codable {
    let name: String
    let text: String?
    let damage: String
}
