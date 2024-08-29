//
//  Others.swift
//  Pokemon
//
//  Created by Adem Mergen on 29.08.2024.
//

import Foundation

struct Version: Codable {
  let generation_ii: GenerationII?
  
  enum CodingKeys: String, CodingKey {
    case generation_ii = "generation-ii"
  }
}
