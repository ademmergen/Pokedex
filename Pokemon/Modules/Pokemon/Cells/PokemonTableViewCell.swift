//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 21.08.2024.
//

import UIKit
import Kingfisher

final class PokemonTableViewCell: UITableViewCell {
  @IBOutlet weak var pokemonNumberLabel: UILabel!
  @IBOutlet weak var pokemonNameLabel: UILabel!
  @IBOutlet weak var pokemonImageView: UIImageView!
  @IBOutlet weak var pokemonContainerView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    pokemonContainerView.layer.cornerRadius = 10
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configure(with pokemon: Pokemon, using viewModel: PokemonViewModel) {
    pokemonNameLabel.text = pokemon.name.capitalized
    if let pokemonID = viewModel.getPokemonID(for: pokemon) {
      pokemonNumberLabel.text = "#\(pokemonID)"
      
      if let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png") {
        pokemonImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
          switch result {
          case .success(_):
            debugPrint("Image loaded")
          case .failure(_):
            debugPrint("Failed to load image.")
          }
        }
      }
    }
  }
}
