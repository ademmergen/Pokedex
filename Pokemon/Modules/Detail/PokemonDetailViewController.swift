//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import UIKit
import Kingfisher

class PokemonDetailViewController: UIViewController {
  
  var pokemon: Pokemon?
  private let viewModel = PokemonDetailViewModel()
  
  @IBOutlet weak var tableView: UITableView!
  
  var abilitiesExpanded: Bool = false
  var statsExpanded: Bool = false
  
  var expandedSection: Int? // Genişletilen bölüm
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInsetAdjustmentBehavior = .never
    
    // Sadece gerekli hücreleri register edin
    tableView.register(UINib(nibName: "PokemonImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonImageCell")
    tableView.register(UINib(nibName: "PokemonDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonDetailCell")
    tableView.register(UINib(nibName: "SpritesTableViewCell", bundle: nil), forCellReuseIdentifier: "SpritesTableViewCell")
    
    tableView.delegate = self
    tableView.dataSource = self
    
    if let pokemon = pokemon {
      let pokemonID = extractID(from: pokemon.url)
      
      // Pokémon detaylarını yükleme
      viewModel.fetchPokemonDetail(pokemonID: pokemonID) { [weak self] result in
        DispatchQueue.main.async {
          switch result {
          case .success(_):
            self?.tableView.reloadData()
          case .failure(let error):
            print("Error fetching details: \(error)")
          }
        }
      }
    }
  }
  
  private func extractID(from url: String) -> Int {
    let urlParts = url.split(separator: "/")
    return Int(urlParts.last ?? "") ?? 0
  }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 6 // Header hücresi için 1 ekstra bölüm ekleniyor
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 200 // Header hücresi için sabit bir yükseklik
    } else if let expandedSection = expandedSection, expandedSection == indexPath.section {
      if expandedSection == 5 {
        // Sprites hücresi genişletilmişse
        return 150 // Örnek yüksekliği, gereksinimlere göre ayarlayın
      }
      // Diğer genişletilmiş hücreler için yüksekliği expandedContent'e göre ayarla
      guard let cell = tableView.cellForRow(at: indexPath) as? PokemonDetailTableViewCell else {
        return UITableView.automaticDimension
      }
      return CGFloat(45 * cell.expandedContent.count) + 48
    } else {
      return 48 // Diğer hücreler için sabit yükseklik
    }
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonImageCell", for: indexPath) as? PokemonImageTableViewCell else {
        return UITableViewCell()
      }
      
      // Pokemon resmini XIB içindeki UIImageView'a yükle
      if let pokemon = pokemon {
        let pokemonID = extractID(from: pokemon.url)
        let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png")
        cell.pokemonImageView.kf.setImage(with: imageUrl)
        cell.pokemonNameLabel.text = pokemon.name
      }
      
      return cell
    } else if indexPath.section == 5 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpritesTableViewCell", for: indexPath) as? SpritesTableViewCell else {
        return UITableViewCell()
      }
      
      // Sprites verilerini ayarlayın
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
          
          
        ].compactMap { $0 }
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
        // Weight
        cell.configure(with: "Weight", value: "\(viewModel.pokemonDetail?.weight ?? 0)")
      case 2:
        // Height
        cell.configure(with: "Height", value: "\(viewModel.pokemonDetail?.height ?? 0)")
      case 3:
        // Abilities
        let abilityNames = viewModel.pokemonDetail?.abilities.map { $0.ability.name } ?? []
        cell.configure(with: "Abilities", expandedContent: abilityNames)
      case 4:
        // Stats
        let statNames = viewModel.pokemonDetail?.stats.map { "\($0.stat.name): \($0.base_stat)" } ?? []
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
    
    if expandedSection == section {
      // Aynı bölüme tıklanırsa genişlemeyi kapat
      expandedSection = nil
    } else {
      // Başka bir bölüme tıklanırsa onu genişlet, diğerlerini kapat
      expandedSection = section
    }
    
    tableView.beginUpdates()
    tableView.reloadSections([section], with: .automatic)
    tableView.endUpdates()
  }
}





