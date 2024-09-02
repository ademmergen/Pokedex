//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import UIKit
import Kingfisher

final class PokemonDetailViewController: UIViewController {
  
  var pokemon: Pokemon?
  private let viewModel = PokemonDetailViewModel()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    loadData()
  }
  
  private func configureTableView() {
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.register(UINib(nibName: "PokemonImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonImageCell")
    tableView.register(UINib(nibName: "PokemonDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonDetailCell")
    tableView.register(UINib(nibName: "SpritesTableViewCell", bundle: nil), forCellReuseIdentifier: "SpritesTableViewCell")
    
    tableView.delegate = self
    tableView.dataSource = self
    
  }
  private func loadData() {
    if let pokemon = pokemon {
      let pokemonID = viewModel.extractID(from: pokemon.url)
      
      viewModel.fetchPokemonDetail(pokemonID: pokemonID) { [weak self] result in
        DispatchQueue.main.async { [weak self] in
          switch result {
          case .success(_):
            self?.tableView.reloadData()
          case .failure(let error):
            debugPrint("Error fetching details: \(error)")
          }
        }
      }
    }
  }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 200
    } else if viewModel.isSectionExpanded(indexPath.section) {
      if indexPath.section == 5 {
        // Sprites hücresi genişletilmişse
        return 150
      }
      // Diğer genişletilmiş hücreler için yüksekliği expandedContent'e göre ayarla
      guard let cell = tableView.cellForRow(at: indexPath) as? PokemonDetailTableViewCell else {
        return 48
      }
      return CGFloat(45 * cell.expandedContent.count) + 48
    } else {
      return 48
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonImageCell", for: indexPath) as? PokemonImageTableViewCell else {
        return UITableViewCell()
      }
      
      // Pokemon resmini XIB içindeki UIImageView'a yükle
      if let pokemon = pokemon {
        let pokemonID = viewModel.extractID(from: pokemon.url)
        let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png")
        cell.pokemonImageView.kf.setImage(with: imageUrl)
        cell.pokemonNameLabel.text = pokemon.name
      }
      
      return cell
    } else if indexPath.section == 5 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpritesTableViewCell", for: indexPath) as? SpritesTableViewCell else {
        return UITableViewCell()
      }
      
      if let sprites = viewModel.pokemonDetail?.sprites {
        cell.sprites = [
          sprites.front_default,
          sprites.back_default,
          sprites.front_shiny,
          sprites.back_shiny,
          sprites.versions?.generation_ii?.crystal?.back_default,
          sprites.versions?.generation_ii?.crystal?.back_shiny,
          sprites.versions?.generation_ii?.crystal?.back_shiny_transparent,
          sprites.versions?.generation_ii?.crystal?.back_transparent,
          sprites.versions?.generation_ii?.crystal?.front_default,
          sprites.versions?.generation_ii?.crystal?.front_shiny,
          sprites.versions?.generation_ii?.crystal?.front_shiny_transparent,
          sprites.versions?.generation_ii?.crystal?.front_transparent
        ].compactMap { $0 } // nil olanlari temizler
      }
      
      cell.downButton.tag = indexPath.section
      cell.downButton.addTarget(self, action: #selector(toggleExpand(_:)), for: .touchUpInside)
      
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailCell", for: indexPath) as? PokemonDetailTableViewCell else {
        return UITableViewCell()
      }
      
      switch indexPath.section {
      case 1:
        cell.configure(with: "Weight", value: "\(viewModel.pokemonDetail?.weight ?? 0)")
      case 2:
        cell.configure(with: "Height", value: "\(viewModel.pokemonDetail?.height ?? 0)")
      case 3:
        let abilityNames = viewModel.abilityNames()
        cell.configure(with: "Abilities", expandedContent: abilityNames)
      case 4:
        let statNames = viewModel.statNames()
        cell.configure(with: "Stats", expandedContent: statNames)
      default:
        break
      }
      
      cell.downButton.tag = indexPath.section
      cell.downButton.addTarget(self, action: #selector(toggleExpand(_:)), for: .touchUpInside)
      
      return cell
    }
  }
  
  @objc func toggleExpand(_ sender: UIButton) {
    let section = sender.tag
    viewModel.toggleExpand(for: section)
    
    tableView.beginUpdates()
    tableView.reloadSections([section], with: .automatic)
    tableView.endUpdates()
  }
}






