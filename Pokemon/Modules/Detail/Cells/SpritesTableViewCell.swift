//
//  SpritesTableViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 29.08.2024.
//

import UIKit

final class SpritesTableViewCell: UITableViewCell {
  @IBOutlet weak var spritesLabel: UILabel!
  @IBOutlet weak var downButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    
    //collectionView.delegate = self
    //collectionView.dataSource = self
    //collectionView.register(UINib(nibName: "SpritesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpritesCollectionViewCell")
  }
  
//  var sprites: [String] = [] { // sprites dizisi her guncelliginde collectionView'de gosterilen veriler guncellenir.
//    didSet {
//      collectionView.reloadData()
//    }
//  }
}

//extension SpritesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return sprites.count
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpritesCollectionViewCell", for: indexPath) as? SpritesCollectionViewCell else {
//      return UICollectionViewCell()
//    }
//    
//    let spriteURL = sprites[indexPath.item]
//    cell.configure(with: spriteURL)
//    return cell
//  }
//}
