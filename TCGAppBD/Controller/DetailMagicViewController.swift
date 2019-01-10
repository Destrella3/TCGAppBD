//
//  DetailMagicViewController.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailMagicViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    public var magicCards: MagicCard!
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollectionView.dataSource = self
    }
    
    
    
}

extension DetailMagicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicCards.foreignNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMagicCell", for: indexPath) as? DetailMagicCollectionViewCell else { return UICollectionViewCell() }
        let magicToSet = magicCards.foreignNames[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: magicToSet.imageUrl) { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                cell.magicImage.image = image
            }
        }
        cell.language.text = magicToSet.language
        cell.magicText.text = magicToSet.text
        cell.cardName.text = magicToSet.name
        return cell
        
    }
}



