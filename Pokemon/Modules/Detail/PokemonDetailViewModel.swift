//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import Foundation

class PokemonDetailViewModel {
  
  var pokemonDetail: PokemonDetail?
  private let detailService = DetailAPIService()
  
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
}
