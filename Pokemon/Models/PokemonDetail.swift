//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Adem Mergen on 21.08.2024.
//

import Foundation

struct PokemonDetail: Codable {
  let sprites: Sprites
  let abilities: [Ability]
  let weight: Int
  let stats: [Stat]
}
