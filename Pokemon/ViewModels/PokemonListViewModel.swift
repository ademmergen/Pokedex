//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import Foundation

class PokemonListViewModel {
  private let apiService: APIService
  var pokemons: [Pokemon] = []
  
  init(apiService: APIService = APIService()) {
    self.apiService = apiService
  }
  
  func fetchPokemons(completion: @escaping () -> Void) {
    apiService.fetchPokemons { [weak self] result in
      switch result {
      case .success(let pokemons):
        self?.pokemons = pokemons
        print("Fetched Pokemons: \(pokemons)")
        completion()
      case .failure(let error):
        print("Error fetching pokemons: \(error)")
        completion()
      }
    }
  }
}

