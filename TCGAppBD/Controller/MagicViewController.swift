//
//  ViewController.swift
//  TCGAppBD
//
//  Created by Biron Su on 1/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {
    
    @IBOutlet weak var magicCollectionView: UICollectionView!
    
    
    private var magicCard = [MagicCard]() {
        didSet {
            DispatchQueue.main.async {
                self.magicCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        magicCollectionView.dataSource = self
        magicCollectionView.delegate = self
        uploadData()
    }
    
    func uploadData() {
        MagicAPIClient.getMagic { (appError, magicCard) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let magicCard = magicCard {
                self.magicCard = magicCard
            }
            if let cards = magicCard {
                self.magicCard = cards.filter{$0.imageUrl != nil && $0.imageUrl != nil}
            }
        }
    }
    
}

extension MagicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagicCell", for: indexPath) as? MagicCollectionViewCell else { return UICollectionViewCell() }
        let magicToSet = magicCard[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: magicToSet.imageUrl ?? "nil") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                cell.magicImageView.image = image
            }
        }
        return cell
    }
}

extension MagicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 175)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = magicCollectionView.cellForItem(at: indexPath) as! MagicCollectionViewCell
        let magic = magicCard[indexPath.row]
    }
}
