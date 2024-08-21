//
//  PokemonListResponse.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import Foundation

struct PokemonListResponse: Codable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [Pokemon]
}
