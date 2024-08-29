//
//  Sprites.swift
//  Pokemon
//
//  Created by Adem Mergen on 21.08.2024.
//

import Foundation

struct Sprites: Codable {
  let back_default: String?
  let back_shiny: String?
  let front_default: String?
  let front_shiny: String?
  let versions: Version?
}
