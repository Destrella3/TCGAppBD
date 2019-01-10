//
//  DetailPokemonViewController.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    var pokecard: PokeCard!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeCollectionView.dataSource = self
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailPokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokecard.attacks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokeCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailPokemonCell", for: indexPath) as? DetailPokemonCollectionViewCell else {return UICollectionViewCell()}
        let pokeToSet = pokecard.attacks[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: pokecard.imageUrlHiRes ?? "nil") { (appError, image) in
            if let appError = appError {
                print("appError \(appError)")
            } else if let image = image {
                self.pokemonImage.image = image
            }
        }
        cell.firstLabel.text = pokeToSet.name
        cell.secondLabel.text = pokeToSet.damage
        if let text = pokeToSet.text {
            cell.textView.text = text
        } else {
            cell.textView.text = "No description"
        }
        return cell
    }
    
    
}
