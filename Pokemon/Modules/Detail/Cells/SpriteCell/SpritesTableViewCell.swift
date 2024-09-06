//
//  SpritesTableViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 29.08.2024.
//

import UIKit

final class SpritesTableViewCell: UITableViewCell {
  @IBOutlet weak var propertyLabel: UILabel!
  @IBOutlet weak var downButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var sprites: [String] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }
  
  func configure(featureName: String, isExpanded: Bool, sprites: [String]) {
    propertyLabel.text = featureName
    self.sprites = sprites
    collectionView.reloadData()

    let buttonImageName = isExpanded ? "chevron.up.circle" : "chevron.down.circle"
    let buttonImage = UIImage(systemName: buttonImageName)
    downButton.setImage(buttonImage, for: .normal)
  }
  
  private func setupCollectionView() {
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: "SpritesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpritesCollectionViewCell")
  }
}

extension SpritesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sprites.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpritesCollectionViewCell", for: indexPath) as? SpritesCollectionViewCell else {
      return UICollectionViewCell()
    }
    let spriteUrl = sprites[indexPath.row]
    cell.configure(with: spriteUrl)
    return cell
  }
}
