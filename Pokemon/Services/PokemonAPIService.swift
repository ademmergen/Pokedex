//
//  PokemonAPIService.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import Foundation

final class PokemonAPIService {
  func fetchPokemons(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
    let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)"
    guard let url = URL(string: urlString) else {
      completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
        return
      }
      
      do {
        let pokemonList = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        completion(.success(pokemonList.results))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
