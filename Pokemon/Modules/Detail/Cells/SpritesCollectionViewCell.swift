//
//  SpritesCollectionViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 29.08.2024.
//

import UIKit

class SpritesCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var spritesImageView: UIImageView!
  
  func configure(with url: String) {
    if let imageUrl = URL(string: url) {
      spritesImageView.kf.setImage(with: imageUrl)
    } else {
      spritesImageView.image = UIImage(named: "placeholder_image") // Yedek bir resim koyabilirsiniz.
    }
  }
}
