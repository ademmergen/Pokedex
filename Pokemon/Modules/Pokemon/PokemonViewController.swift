//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import UIKit

final class PokemonViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  private let viewModel = PokemonViewModel()
  private let activityIndicator = UIActivityIndicatorView(style: .medium)
  
  private let pokemonTableViewCellIdentifier = "PokemonTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configurePokemonsTableView()
    
    activityIndicator.hidesWhenStopped = true //Animasyon durduğunda otomatik olarak gizlenmesini sağlar.
    activityIndicator.color = .gray
    
    viewModel.fetchPokemons { [weak self] in
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }
  }
  
  private func configurePokemonsTableView() {
    let nib = UINib(nibName: pokemonTableViewCellIdentifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "PokemonCell")
    tableView.tableFooterView = activityIndicator
    tableView.separatorStyle = .none
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.filteredPokemons.count // Her hücre için ayrı bir section
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let selectedPokemon = viewModel.filteredPokemons[indexPath.section]
    
    let storyboard = UIStoryboard(name: "PokemonDetail", bundle: nil)
    if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? PokemonDetailViewController {
      detailVC.pokemon = selectedPokemon
      
      navigationController?.pushViewController(detailVC, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1 // Her section'da sadece bir hücre olacak
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let pokemon = viewModel.filteredPokemons[indexPath.section]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
    cell.configure(with: pokemon, using: viewModel)
    cell.selectionStyle = .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.section >= 1000 {
      DispatchQueue.main.async { [weak self] in
        self?.activityIndicator.stopAnimating()
        self?.activityIndicator.isHidden = true
      }
      
      return
    }
    
    if indexPath.section == viewModel.pokemons.count - 1 {
      // Activity Indicator'ı Göster
      DispatchQueue.main.async { [weak self] in
        self?.activityIndicator.startAnimating()
      }
      
      // Yeni verileri yükle
      viewModel.fetchPokemons { [weak self] in
        DispatchQueue.main.async { [weak self] in
          // Veri yüklendiğinde Activity Indicator'ı durdur ve gizle
          self?.activityIndicator.stopAnimating()
          self?.tableView.reloadData()
        }
      }
    }
  }
}

// MARK: - UISearchBarDelegate
extension PokemonViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.filterPokemons(with: searchText)
    
    tableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder() // Arama butonuna tıklandığında klavyeyi kapatır
  }
}
