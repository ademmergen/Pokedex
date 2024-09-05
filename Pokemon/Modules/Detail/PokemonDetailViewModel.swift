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
    detailService.fetchPokemonDetail(pokemonID: pokemonID) { [weak self] result in
      switch result {
      case .success(let detail):
        self?.pokemonDetail = detail
        self?.setupCellModels()
        
        completion(.success(detail))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  private func setupCellModels() {
    guard let pokemonDetail = pokemonDetail else {return}
    
    let imageCellModel = PokemonDetailCellModel(type: .singleImage, featureName: "Pokemon")
    cellModels.append(imageCellModel)
    
    let weightCellModel = PokemonDetailCellModel(type: .singleValue, featureName: "Weight", featureValue: "\(pokemonDetail.weight)")
    cellModels.append(weightCellModel)
    
    let heightCellModel = PokemonDetailCellModel(type: .singleValue, featureName: "Height", featureValue: "\(pokemonDetail.height)")
    cellModels.append(heightCellModel)
    
    let abilities = abilityNames()
    let abilitiesCellModel = PokemonDetailCellModel(type: .multipleValue, featureName: "Abilities", expandedContent: abilities)
    cellModels.append(abilitiesCellModel)
    
    let stats = statNames()
    let statsCellModel = PokemonDetailCellModel(type: .multipleValue, featureName: "Stats", expandedContent: stats)
    cellModels.append(statsCellModel)
    
    let spriteURLs = spriteImages()
    let spritesCellModel = PokemonDetailCellModel(type: .multipleImage, featureName: "Sprites", expandedContent: spriteURLs)
    cellModels.append(spritesCellModel)
  }
  
  // URL'den ID çıkarma işlevi
  func extractID(from url: String) -> Int {
    let urlParts = url.split(separator: "/")
    
    return Int(urlParts.last ?? "") ?? 0
  }
  
  // Ability isimlerini döndürme işlevi
  private func abilityNames() -> [String] {
    
    return pokemonDetail?.abilities.map { $0.ability.name } ?? []
  }
  
  // Stat isimlerini döndürme işlevi
  private func statNames() -> [String] {
    
    return pokemonDetail?.stats.map { "\($0.stat.name): \($0.baseStat)" } ?? []
  }

  private func spriteImages() -> [String] {
    guard let sprites = pokemonDetail?.sprites else { return [] }
    
    let spriteList = [
      sprites.backDefault,
      sprites.backShiny,
      sprites.frontDefault,
      sprites.frontShiny
    ]
    
    // compactMap ile nil olmayanları filtreler ve döndürür
    return spriteList.compactMap { $0 }
  }
}

