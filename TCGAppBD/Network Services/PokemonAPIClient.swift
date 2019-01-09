//
//  PokemonAPIClient.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PokemonAPIClient {
    static func getPokemon(completionHandler: @escaping ((AppError?), [PokemonCards]?) -> Void) {
        let getPokemonEndPoint = "https://api.pokemontcg.io/v1/cards?contains=imageUrl,imageUrlHiRes,attacks"
        NetworkHelper.shared.performDataTask(endpointURLString: getPokemonEndPoint) { (appError, data, response) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let pokemon = try JSONDecoder().decode([PokemonCards].self, from: data)
                    completionHandler(nil, pokemon)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
