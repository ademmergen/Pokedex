//
//  PokemonImageTableViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 28.08.2024.
//

import UIKit

final class PokemonImageTableViewCell: UITableViewCell {
  
  @IBOutlet weak var pokemonImageView: UIImageView!
  @IBOutlet weak var pokemonNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(with imageUrlString: String?, pokemonName: String?) {
    if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
      pokemonImageView.kf.setImage(with: imageUrl)
    } else {
      pokemonImageView.image = nil
    }
    pokemonNameLabel.text = pokemonName ?? "Unknown Pokémon"
  }
}
