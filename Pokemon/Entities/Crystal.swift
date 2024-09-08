//
//  Crystal.swift
//  Pokemon
//
//  Created by Adem Mergen on 29.08.2024.
//

import Foundation

struct Crystal: Codable {
  let backDefault: String?
  let backShiny: String?
  let backShinyTransparent: String?
  let backTransparent: String?
  let frontDefault: String?
  let frontShiny: String?
  let frontShinyTransparent: String?
  let frontTransparent: String?
  
  enum CodingKeys: String, CodingKey {
    case backDefault = "back_default"
    case backShiny = "back_shiny"
    case backShinyTransparent = "back_shiny_transparent"
    case backTransparent = "back_transparent"
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
    case frontShinyTransparent = "front_shiny_transparent"
    case frontTransparent = "front_transparent"
  }
}
