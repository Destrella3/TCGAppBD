//
//  MagicAPIClient.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class MagicAPIClient {
    static func getMagic(completionHandler: @escaping (AppError?, [MagicCard]?) -> Void) {
        let getMagicEndPoint = "https://api.magicthegathering.io/v1/cards?contains=imageUrl"
        NetworkHelper.shared.performDataTask(endpointURLString: getMagicEndPoint) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let magics = try JSONDecoder().decode(MagicCards.self, from: data)
                    completionHandler(nil, magics.cards)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}

