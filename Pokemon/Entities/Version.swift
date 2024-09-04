//
//  Others.swift
//  Pokemon
//
//  Created by Adem Mergen on 29.08.2024.
//

import Foundation

struct Version: Codable {
  let generationIi: GenerationII?
  
  enum CodingKeys: String, CodingKey {
    case generationIi = "generation-ii"
  }
}
