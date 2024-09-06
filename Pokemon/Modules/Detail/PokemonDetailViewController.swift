//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import UIKit
import Kingfisher

enum PokemonDetailCellType {
  case singleValue
  case multipleValue
  case singleImage
  case multipleImage
  
  func height(isSelected: Bool, expandedContentCount: Int) -> CGFloat {
    switch self {
    case .singleValue:
      return 48
    case .multipleValue:
      return isSelected ? CGFloat((expandedContentCount + 1) * 45) : 48
    case .singleImage:
      return 200
    case .multipleImage:
      return isSelected ? 150 : 48
    }
  }
  
  var cellIdentifier: String {
    switch self {
    case .singleValue, .multipleValue:
      return "PokemonDetailCell"
    case .singleImage:
      return "PokemonImageCell"
    case .multipleImage:
      return "SpritesTableViewCell"
    }
  }
}

final class PokemonDetailCellModel {
  let type: PokemonDetailCellType
  let featureName: String
  let featureValue: String?
  let expandedContent: [String]?
  var isSelected: Bool = false
  
  init(type: PokemonDetailCellType, featureName: String, featureValue: String? = nil, expandedContent: [String]? = nil) {
    self.type = type
    self.featureName = featureName
    self.featureValue = featureValue
    self.expandedContent = expandedContent
  }
  
  var cellHeight: CGFloat {
    return type.height(isSelected: isSelected, expandedContentCount: expandedContent?.count ?? 0)
    
  }
}

final class PokemonDetailViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var pokemon: Pokemon?
  private let viewModel = PokemonDetailViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    loadData()
  }
  
  private func configureTableView() {
    tableView.contentInsetAdjustmentBehavior = .never
    
    let pokemonImageNib = UINib(nibName: "PokemonImageTableViewCell", bundle: nil)
    tableView.register(pokemonImageNib, forCellReuseIdentifier: "PokemonImageCell")
    let pokemonDetailNib = UINib(nibName: "PokemonDetailTableViewCell", bundle: nil)
    tableView.register(pokemonDetailNib, forCellReuseIdentifier: "PokemonDetailCell")
    let spritesNib = UINib(nibName: "SpritesTableViewCell", bundle: nil)
    tableView.register(spritesNib, forCellReuseIdentifier: "SpritesTableViewCell")
  }
  
  private func loadData() {
    guard let pokemon = pokemon else { return }
    let pokemonID = viewModel.extractID(from: pokemon.url)
    
    viewModel.fetchPokemonDetail(pokemonID: pokemonID) { [weak self] result in
      DispatchQueue.main.async { [weak self] in
        switch result {
        case .success:
          self?.tableView.reloadData()
        case .failure(let error):
          debugPrint("Error fetching details: \(error)")
        }
      }
    }
  }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.cellModels.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.cellModels[indexPath.section].cellHeight
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellModel = viewModel.cellModels[indexPath.section]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.type.cellIdentifier, for: indexPath)
    
    switch cellModel.type {
      
    case .singleImage:
      let cell = cell as! PokemonImageTableViewCell
      cell.configure(with: viewModel.pokemonDetail?.sprites.frontDefault, pokemonName: pokemon?.name)
      
    case .singleValue:
      let cell = cell as! PokemonDetailTableViewCell
      cell.configure(featureName: cellModel.featureName, featureValue: cellModel.featureValue ?? "")
      
    case .multipleValue:
      let cell = cell as! PokemonDetailTableViewCell
      cell.configure(featureName: cellModel.featureName, isExpanded: cellModel.isSelected, expandedContent: cellModel.expandedContent ?? [""])
      
    case .multipleImage:
      let cell = cell as! SpritesTableViewCell
      cell.configure(featureName: cellModel.featureName, isExpanded: cellModel.isSelected, sprites: cellModel.expandedContent ?? [])
    }
    
    cell.selectionStyle = .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedPokemonDetail = viewModel.cellModels[indexPath.section]
    selectedPokemonDetail.isSelected = !selectedPokemonDetail.isSelected
    
    tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    tableView.reloadRows(at: [indexPath], with: .none)
  }
}
