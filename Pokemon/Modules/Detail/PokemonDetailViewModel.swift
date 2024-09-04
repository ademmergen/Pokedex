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
  var cellModels: [PokemonDetailCellModel] = []
  
  func fetchPokemonDetail(pokemonID: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
    detailService.fetchPokemonDetail(pokemonID: pokemonID) { result in
      switch result {
      case .success(let detail):
        self.pokemonDetail = detail
        self.setupCellModels()
        
        completion(.success(detail))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  private func setupCellModels() {
    guard let pokemonDetail = pokemonDetail else {return}
    
    let imageCellModel = PokemonDetailCellModel(cellType: .singleImage, featureName: "Pokemon", height: 200)
    cellModels.append(imageCellModel)
    
    let weightCellModel = PokemonDetailCellModel(cellType: .singleValue, featureName: "Weight", featureValue: "\(pokemonDetail.weight)", height: 48)
    cellModels.append(weightCellModel)
    
    let heightCellModel = PokemonDetailCellModel(cellType: .singleValue, featureName: "Height", featureValue: "\(pokemonDetail.height)", height: 48)
    cellModels.append(heightCellModel)
    
    let abilities = abilityNames()
    let abilitiesCellModel = PokemonDetailCellModel(cellType: .multipleValue, featureName: "Abilities", expandedContent: abilities, height: 48)
    cellModels.append(abilitiesCellModel)
    
    let stats = statNames()
    let statsCellModel = PokemonDetailCellModel(cellType: .multipleValue, featureName: "Stats", expandedContent: stats, height: 48)
    cellModels.append(statsCellModel)
    
    let spritesCellModel = PokemonDetailCellModel(cellType: .multipleImage, featureName: "Sprites", height: 48)
    cellModels.append(spritesCellModel)
    
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
    return pokemonDetail?.stats.map { "\($0.stat.name): \($0.baseStat)" } ?? []
  }
}

