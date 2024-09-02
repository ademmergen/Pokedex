//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import Foundation

final class PokemonDetailViewModel {
  
  private let detailService = PokemonDetailAPIService()
  var pokemonDetail: PokemonDetail?
  var expandedSection: Int?
  
  func fetchPokemonDetail(pokemonID: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
    detailService.fetchPokemonDetail(pokemonID: pokemonID) { result in
      switch result {
      case .success(let detail):
        self.pokemonDetail = detail
        completion(.success(detail))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  // URL'den ID çıkarma işlevi
  func extractID(from url: String) -> Int {
    let urlParts = url.split(separator: "/")
    return Int(urlParts.last ?? "") ?? 0
  }
  
  // Ability isimlerini döndürme işlevi
  func abilityNames() -> [String] {
    return pokemonDetail?.abilities.map { $0.ability.name } ?? []
  }
  
  // Stat isimlerini döndürme işlevi
  func statNames() -> [String] {
    return pokemonDetail?.stats.map { "\($0.stat.name): \($0.base_stat)" } ?? []
  }
  
  // Genişletilmiş durumları yönetmek için fonksiyon
  func toggleExpand(for section: Int) {
    if expandedSection == section {
      expandedSection = nil
    } else {
      expandedSection = section
    }
  }
  
  func isSectionExpanded(_ section: Int) -> Bool {
    return expandedSection == section
  }
}

