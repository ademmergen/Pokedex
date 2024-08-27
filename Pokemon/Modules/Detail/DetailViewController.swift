//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 26.08.2024.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
  
  var pokemon: Pokemon?
  private let viewModel = PokemonDetailViewModel()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var pokemonLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UINib(nibName: "PokemonDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonDetailCell")
    
    tableView.delegate = self
    tableView.dataSource = self
    
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
    return 1 // Başlık ve detayları göstermek için bir hücre kullanacağız
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailCell", for: indexPath) as? PokemonDetailTableViewCell else {
      return UITableViewCell()
    }
    
    return cell
  }
}



