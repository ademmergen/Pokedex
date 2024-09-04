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
}
