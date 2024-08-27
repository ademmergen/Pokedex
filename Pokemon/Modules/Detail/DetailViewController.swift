//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

//import UIKit
//import Kingfisher
//
//class DetailViewController: UIViewController {
//  
//  var pokemon: Pokemon?
//  private let viewModel = PokemonDetailViewModel()
//  
//  @IBOutlet weak var tableView: UITableView!
//  @IBOutlet weak var pokemonImage: UIImageView!
//  @IBOutlet weak var pokemonLabel: UILabel!
//  
//  var expandedSection: Int? // Genişletilen bölüm
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    tableView.register(UINib(nibName: "PokemonDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonDetailCell")
//    
//    tableView.delegate = self
//    tableView.dataSource = self
//    
//    tableView.rowHeight = UITableView.automaticDimension
//    tableView.estimatedRowHeight = 70 // Başlangıç yüksekliği tahmini
//    
//    pokemonLabel.text = pokemon?.name
//    
//    if let pokemon = pokemon {
//      let pokemonID = extractID(from: pokemon.url)
//      
//      // Pokémon resmini yükleme
//      if let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png") {
//        pokemonImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
//          switch result {
//          case .success(_):
//            print("Image loaded successfully.")
//          case .failure(let error):
//            print("Failed to load image: \(error)")
//          }
//        }
//      }
//      
//      // Pokémon detaylarını yükleme
//      viewModel.fetchPokemonDetail(pokemonID: pokemonID) { [weak self] result in
//        DispatchQueue.main.async {
//          switch result {
//          case .success(_):
//            self?.tableView.reloadData()
//          case .failure(let error):
//            print("Error fetching details: \(error)")
//          }
//        }
//      }
//    }
//  }
//  
//  private func extractID(from url: String) -> Int {
//    let urlParts = url.split(separator: "/")
//    return Int(urlParts.last ?? "") ?? 0
//  }
//}
//
//extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
//  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 1
//  }
//  
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 4 // Weight, Height, Abilities, Stats
//  }
//  
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    if let expandedSection = expandedSection, expandedSection == indexPath.section {
//      // Genişletilmiş hücrenin yüksekliğini expandedContent'e göre ayarla
//      guard let cell = tableView.cellForRow(at: indexPath) as? PokemonDetailTableViewCell else {
//        return UITableView.automaticDimension
//      }
//      return CGFloat(44 * cell.expandedContent.count) + 60
//    } else {
//      // Diğer hücreler için sabit yükseklik
//      return 60
//    }
//  }
//  
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    tableView.deselectRow(at: indexPath, animated: true)
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailCell", for: indexPath) as? PokemonDetailTableViewCell else {
//      return UITableViewCell()
//    }
//    
//    switch indexPath.section {
//    case 0:
//      // Weight
//      cell.configure(with: "Weight", value: "\(viewModel.pokemonDetail?.weight ?? 0)")
//    case 1:
//      // Height
//      cell.configure(with: "Height", value: "\(viewModel.pokemonDetail?.height ?? 0)")
//    case 2:
//      // Abilities
//      let abilityNames = viewModel.pokemonDetail?.abilities.map { $0.ability.name } ?? []
//      cell.configure(with: "Abilities", expandedContent: abilityNames)
//    case 3:
//      // Stats
//      let statNames = viewModel.pokemonDetail?.stats.map { "\($0.stat.name): \($0.base_stat)" } ?? []
//      cell.configure(with: "Stats", expandedContent: statNames)
//    default:
//      break
//    }
//    
//    cell.downButton.tag = indexPath.section
//    cell.downButton.addTarget(self, action: #selector(toggleExpand(_:)), for: .touchUpInside)
//    
//    return cell
//  }
//  
//  @objc func toggleExpand(_ sender: UIButton) {
//    let section = sender.tag
//    
//    if expandedSection == section {
//      // Aynı bölüme tıklanırsa genişlemeyi kapat
//      expandedSection = nil
//    } else {
//      // Başka bir bölüme tıklanırsa onu genişlet, diğerlerini kapat
//      expandedSection = section
//    }
//    
//    tableView.beginUpdates()
//    tableView.reloadSections([section], with: .automatic)
//    tableView.endUpdates()
//  }
//}


import UIKit
import Kingfisher

class DetailViewController: UIViewController {

  var pokemon: Pokemon?
  private let viewModel = PokemonDetailViewModel()

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var pokemonLabel: UILabel!
  
  var abilitiesExpanded: Bool = false
      var statsExpanded: Bool = false

  var expandedSection: Int? // Genişletilen bölüm

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UINib(nibName: "PokemonDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonDetailCell")

    tableView.delegate = self
    tableView.dataSource = self

    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 70 // Başlangıç yüksekliği tahmini

    pokemonLabel.text = pokemon?.name

    if let pokemon = pokemon {
      let pokemonID = extractID(from: pokemon.url)

      // Pokémon resmini yükleme
      if let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png") {
        pokemonImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
          switch result {
          case .success(_):
            print("Image loaded successfully.")
          case .failure(let error):
            print("Failed to load image: \(error)")
          }
        }
      }

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

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 4 // Weight, Height, Abilities, Stats
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let expandedSection = expandedSection, expandedSection == indexPath.section {
      // Genişletilmiş hücrenin yüksekliğini expandedContent'e göre ayarla
      guard let cell = tableView.cellForRow(at: indexPath) as? PokemonDetailTableViewCell else {
        return UITableView.automaticDimension
      }
      return CGFloat(44 * cell.expandedContent.count) + 60
    } else {
      // Diğer hücreler için sabit yükseklik
      return 60
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailCell", for: indexPath) as? PokemonDetailTableViewCell else {
      return UITableViewCell()
    }

    switch indexPath.section {
    case 0:
      // Weight
      cell.configure(with: "Weight", value: "\(viewModel.pokemonDetail?.weight ?? 0)")
    case 1:
      // Height
      cell.configure(with: "Height", value: "\(viewModel.pokemonDetail?.height ?? 0)")
    case 2:
      // Abilities
      let abilityNames = viewModel.pokemonDetail?.abilities.map { $0.ability.name } ?? []
      cell.configure(with: "Abilities", expandedContent: abilityNames)
    case 3:
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




