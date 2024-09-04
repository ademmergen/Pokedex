//
//  Stat.swift
//  Pokemon
//
//  Created by Adem Mergen on 21.08.2024.
//

import Foundation

struct Stat: Codable {
  let baseStat: Int
  let stat: StatInfo
  
  enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case stat
  }
}
