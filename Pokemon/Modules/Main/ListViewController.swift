//
//  ViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import UIKit

class ListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let viewModel = PokemonListViewModel()
  private let activityIndicator = UIActivityIndicatorView(style: .medium)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    searchBar.delegate = self
    
    let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "PokemonCell")
    
    tableView.separatorStyle = .none
    
    activityIndicator.hidesWhenStopped = true //Animasyon durduğunda otomatik olarak gizlenmesini sağlar.
    activityIndicator.color = .gray
    tableView.tableFooterView = activityIndicator
    
    viewModel.fetchPokemons {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.filteredPokemons.count // Her hücre için ayrı bir section
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let selectedPokemon = viewModel.filteredPokemons[indexPath.section]
    
    let storyboard = UIStoryboard(name: "Detail", bundle: nil)
    if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
      detailVC.pokemon = selectedPokemon
      navigationController?.pushViewController(detailVC, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1 // Her section'da sadece bir hücre olacak
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else {
      return UITableViewCell()
    }
    
    let pokemon = viewModel.filteredPokemons[indexPath.section]
    cell.configure(with: pokemon, using: viewModel)
    
    cell.selectionStyle = .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if indexPath.section >= 1000 {
      DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
      }
      return
    }
    
    if indexPath.section == viewModel.pokemons.count - 1 {
      // Activity Indicator'ı Göster
      DispatchQueue.main.async {
        self.activityIndicator.startAnimating()
      }
      
      // Yeni verileri yükle
      viewModel.fetchPokemons {
        DispatchQueue.main.async {
          // Veri yüklendiğinde Activity Indicator'ı durdur ve gizle
          self.activityIndicator.stopAnimating()
          self.tableView.reloadData()
        }
      }
    }
  }
}

// MARK: - UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.filterPokemons(with: searchText)
    tableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder() // Arama butonuna tıklandığında klavyeyi kapatır
  }
}
