//
//  ViewController.swift
//  Pokemon
//
//  Created by Adem Mergen on 20.08.2024.
//

import UIKit

class ViewController: UIViewController {
  
  let viewModel = PokemonListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.fetchPokemons {
      
    }
  }
}
