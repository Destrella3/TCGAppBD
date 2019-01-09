//
//  PokemonViewController.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    var pokemonCards = [PokeCard](){
        didSet {
            DispatchQueue.main.async {
                self.pokeCollectionView.reloadData()
            }
        }
    }
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeCollectionView.dataSource = self
        pokeCollectionView.delegate = self
        updateData()
    }
    func updateData() {
        PokemonAPIClient.getPokemon { (appError, data) in
            if let appError = appError {
                print("Error \(appError)")
            } else if let data = data {
               self.pokemonCards = data
            }
        }
    }
}

extension PokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokeCollectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCollectionViewCell else {return UICollectionViewCell()}
        let pokeToSet = pokemonCards[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: pokeToSet.imageUrl ?? "nil") { (appError, image) in
            if let appError = appError {
                print("appError \(appError)")
            } else if let image = image {
                cell.pokemonImage.image = image
            }
        }
        
        return cell
    }
}

extension PokemonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 175)
    }
}
