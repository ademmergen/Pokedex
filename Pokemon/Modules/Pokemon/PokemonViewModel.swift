//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import Foundation
import UIKit

final class PokemonViewModel {
  private let apiService = APIService()
  private var offset = 0
  private let limit = 20
  private var isLoading = false
  
  var pokemons: [Pokemon] = []
  var filteredPokemons: [Pokemon] = []
  
  func fetchPokemons(completion: @escaping () -> Void) {
    guard !isLoading else { return }
    isLoading = true
    
    // Gecikme
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.75) { [weak self] in
      guard let self = self else { return }
      
      self.apiService.fetchPokemons(offset: self.offset, limit: self.limit) { [weak self] result in
        guard let self = self else { return }
        
        self.isLoading = false
        
        switch result {
        case .success(let newPokemons):
          self.pokemons.append(contentsOf: newPokemons)
          self.filteredPokemons = self.pokemons
          self.offset += self.limit
          
          completion()
        case .failure(let error):
          debugPrint("Error fetching pokemons: \(error)")
          
          completion()
        }
      }
    }
  }
  
  func filterPokemons(with searchText: String) {
    if searchText.isEmpty {
      filteredPokemons = pokemons
    } else {
      filteredPokemons = pokemons.filter { $0.name.contains(searchText.lowercased()) }
    }
  }
  
  func getPokemonID(for pokemon: Pokemon) -> Int? {
    if let index = pokemons.firstIndex(where: { $0.name == pokemon.name }) {
      return index + 1
    }
    
    return nil
  }
}
