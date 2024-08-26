//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Adem Mergen on 21.08.2024.
//

import UIKit

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
  
  func configure(with pokemon: Pokemon, at index: Int, using viewModel: PokemonListViewModel) {
    pokemonNameLabel.text = pokemon.name.capitalized
    pokemonNumberLabel.text = "#\(index + 1)"
    
    if let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(index + 1).png") {
      viewModel.fetchImage(from: url) { image in
        DispatchQueue.main.async {
          self.pokemonImageView.image = image
        }
      }
    }
  }
}
