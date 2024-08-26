//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import Foundation
import UIKit

final class PokemonListViewModel {
  private let apiService: APIService
  var pokemons: [Pokemon] = []
  private var offset: Int = 0
  private let limit: Int = 20
  private var isLoading: Bool = false
  
  init(apiService: APIService = APIService()) {
    self.apiService = apiService
  }
  
  func fetchPokemons(completion: @escaping () -> Void) {
    guard !isLoading else { return }
    isLoading = true
    
    // Gecikme
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.75) {
      self.apiService.fetchPokemons(offset: self.offset, limit: self.limit) { [weak self] result in
        guard let self = self else { return }
        self.isLoading = false
        switch result {
        case .success(let newPokemons):
          self.pokemons.append(contentsOf: newPokemons)
          self.offset += self.limit
          
          completion()
        case .failure(let error):
          debugPrint("Error fetching pokemons: \(error)")
          
          completion()
        }
      }
    }
  }
  
  func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      completion(UIImage(data: data))
    }.resume()
  }
}
