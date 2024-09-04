//
//  Sprites.swift
//  Pokemon
//
//  Created by Adem Mergen on 21.08.2024.
//

import Foundation

struct Sprites: Codable {
  let backDefault: String?
  let backShiny: String?
  let frontDefault: String?
  let frontShiny: String?
  let versions: Version?
  
  enum CodingKeys: String, CodingKey {
    case backDefault = "back_default"
    case backShiny = "back_shiny"
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
    case versions
  }
}
