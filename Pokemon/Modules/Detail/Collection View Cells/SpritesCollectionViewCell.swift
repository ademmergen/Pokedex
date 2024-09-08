//
//  SpritesCollectionViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 29.08.2024.
//

import UIKit

final class SpritesCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var spritesImageView: UIImageView!
  
  func configure(with url: String) {
    if let imageUrl = URL(string: url) {
      spritesImageView.kf.setImage(with: imageUrl)
    } else {
      debugPrint("Invalid URL: \(url)")
    }
  }
}
