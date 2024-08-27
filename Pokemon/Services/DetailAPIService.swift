//
//  DetailAPIService.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import Foundation

class DetailAPIService {
  func fetchPokemonDetail(pokemonID: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonID)")!
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
        let pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
        completion(.success(pokemonDetail))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
